import string
import random
from datetime import datetime
from flask import jsonify, make_response, abort
from dotenv import dotenv_values
from pymongo import MongoClient

config = dotenv_values(".env")
client = MongoClient(config['MONGODB_ENDPOINT']) # Docker
db = client.tododb

print(config['MONGODB_ENDPOINT'])

def get_dict_from_mongodb(search_key):
    itens_db = db.cartoes.find()
    CARDS = {}
    for i in itens_db:
            i.pop('_id') # retira id: criado automaticamente pelo mongodb
            item = dict(i)
            CARDS[item[search_key]] = (i)
    return CARDS

def get_timestamp():
    return datetime.now().strftime(("%Y-%m-%d %H:%M:%S"))

def card_number_generator(size=16, chars=string.digits):
    return ''.join(random.choice(chars) for _ in range(size))

def read_all():
    CARDS = get_dict_from_mongodb("timestamp")
    dict_cartoes = [CARDS[key] for key in sorted(CARDS.keys())]
    cartoes = jsonify(dict_cartoes)
    qtd = len(dict_cartoes)
    content_range = "cartoes 0-"+str(qtd)+"/"+str(qtd)
    # Configura headers
    cartoes.headers['Access-Control-Allow-Origin'] = '*'
    cartoes.headers['Access-Control-Expose-Headers'] = 'Content-Range'
    cartoes.headers['Content-Range'] = content_range
    return cartoes


def read_all_by_status(ativo: bool):
    itens_db = db.cartoes.find({"ativo": ativo})
    CARDS = {}
    for i in itens_db:
            i.pop('_id') # retira id: criado automaticamente pelo mongodb
            item = dict(i)
            CARDS[item["numeroCartao"]] = (i)
    dict_cartoes = [CARDS[key] for key in sorted(CARDS.keys())]
    cartoes = jsonify(dict_cartoes)
    qtd = len(dict_cartoes)
    content_range = "cartoes 0-"+str(qtd)+"/"+str(qtd)
    # Configura headers
    cartoes.headers['Access-Control-Allow-Origin'] = '*'
    cartoes.headers['Access-Control-Expose-Headers'] = 'Content-Range'
    cartoes.headers['Content-Range'] = content_range
    return cartoes


def read_one(numeroCartao):
    CARDS = get_dict_from_mongodb("numeroCartao")
    if numeroCartao in CARDS:
        card = CARDS.get(numeroCartao)
    else:
        abort(
            404, "Cartão {numeroCartao} não encontrado".format(numeroCartao=numeroCartao)
        )
    return card


def create(card):
    emailProprietario = card.get("emailProprietario", None)
    emailBeneficiario = card.get("emailBeneficiario", None)
    prazo = card.get("prazo", None)
    saldo = card.get("saldo", None)
    CARDS = get_dict_from_mongodb("emailProprietario")
    if emailBeneficiario is not None and emailProprietario is not None and prazo is not None:
        item = {
            "emailProprietario": emailProprietario,
            "emailBeneficiario": emailBeneficiario,
            "saldo": saldo,
            "ativo": True,
            "numeroCartao": card_number_generator(),
            "prazo": prazo,
            "timestamp": get_timestamp(),
        }
        db.cartoes.insert_one(item)
        return make_response(
            "{emailBeneficiario} criado com sucesso".format(emailBeneficiario=emailBeneficiario), 201
        )
    else:
        abort(
            406,
            "Cartão associado ao email {emailBeneficiario} já existe".format(emailBeneficiario=emailBeneficiario),
        )


def update(numeroCartao, transacao):
    query = { "numeroCartao": numeroCartao }
    CARDS = get_dict_from_mongodb("numeroCartao")

    if numeroCartao in CARDS:
        card = CARDS.get(numeroCartao)
        novo_saldo = float(card["saldo"]) - float(transacao.get("valor"))
        if novo_saldo >= 0 and card["ativo"] is not False:
            update = { "$set": {
                    "saldo": novo_saldo,
                    "ativo": False,
                    "timestamp": get_timestamp(), } 
                }
            db.cartoes.update_one(query, update)
            CARD = get_dict_from_mongodb("numeroCartao")
            return CARD[numeroCartao]
        else:
            abort(
                404, "Cartão com saldo insuficiente"
            )
    else:
        abort(
            404, "Cartão com numeração {numeroCartao} não encontrado".format(numeroCartao=numeroCartao)
        )

def delete(numeroCartao):
    query = { "numeroCartao": numeroCartao }
    CARDS = get_dict_from_mongodb("numeroCartao")
    if numeroCartao in CARDS:
        # del CARDS[numeroCartao]
        db.cartoes.delete_one(query)
        return make_response(
            "{numeroCartao} deletado com sucesso".format(numeroCartao=numeroCartao), 200
        )
    else:
        abort(
            404, "Cartão com numeração {numeroCartao} não encontrado".format(numeroCartao=numeroCartao)
        )

