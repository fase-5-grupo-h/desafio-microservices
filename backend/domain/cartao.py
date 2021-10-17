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
            CARDS[item["numero_cartao"]] = (i)
    dict_cartoes = [CARDS[key] for key in sorted(CARDS.keys())]
    cartoes = jsonify(dict_cartoes)
    qtd = len(dict_cartoes)
    content_range = "cartoes 0-"+str(qtd)+"/"+str(qtd)
    # Configura headers
    cartoes.headers['Access-Control-Allow-Origin'] = '*'
    cartoes.headers['Access-Control-Expose-Headers'] = 'Content-Range'
    cartoes.headers['Content-Range'] = content_range
    return cartoes


def read_one(numero_cartao):
    CARDS = get_dict_from_mongodb("numero_cartao")
    if numero_cartao in CARDS:
        card = CARDS.get(numero_cartao)
    else:
        abort(
            404, "Cartão {numero_cartao} não encontrado".format(numero_cartao=numero_cartao)
        )
    return card


def create(card):
    email_proprietario = card.get("email_proprietario", None)
    email_beneficiario = card.get("email_beneficiario", None)
    prazo = card.get("prazo", None)
    saldo = card.get("saldo", None)
    CARDS = get_dict_from_mongodb("email_proprietario")
    if email_beneficiario not in CARDS and email_beneficiario is not None and email_proprietario is not None and prazo is not None:
        item = {
            "email_proprietario": email_proprietario,
            "email_beneficiario": email_beneficiario,
            "saldo": saldo,
            "ativo": True,
            "numero_cartao": card_number_generator(),
            "prazo": prazo,
            "timestamp": get_timestamp(),
        }
        db.cartoes.insert_one(item)
        return make_response(
            "{email_beneficiario} criado com sucesso".format(email_beneficiario=email_beneficiario), 201
        )
    else:
        abort(
            406,
            "Cartão associado ao email {email_beneficiario} já existe".format(email_beneficiario=email_beneficiario),
        )


def update(numero_cartao, transacao):
    query = { "numero_cartao": numero_cartao }
    CARDS = get_dict_from_mongodb("numero_cartao")

    if numero_cartao in CARDS:
        card = CARDS.get(numero_cartao)
        novo_saldo = float(card["saldo"]) - float(transacao.get("valor"))
        if novo_saldo >= 0 and card["ativo"] is not False:
            update = { "$set": {
                    "saldo": novo_saldo,
                    "ativo": False,
                    "timestamp": get_timestamp(), } 
                }
            db.cartoes.update_one(query, update)
            CARD = get_dict_from_mongodb("numero_cartao")
            return CARD[numero_cartao]
        else:
            abort(
                404, "Cartão com saldo insuficiente"
            )
    else:
        abort(
            404, "Cartão com numeração {numero_cartao} não encontrado".format(numero_cartao=numero_cartao)
        )

def delete(numero_cartao):
    query = { "numero_cartao": numero_cartao }
    CARDS = get_dict_from_mongodb("numero_cartao")
    if numero_cartao in CARDS:
        # del CARDS[numero_cartao]
        db.cartoes.delete_one(query)
        return make_response(
            "{numero_cartao} deletado com sucesso".format(numero_cartao=numero_cartao), 200
        )
    else:
        abort(
            404, "Cartão com numeração {numero_cartao} não encontrado".format(numero_cartao=numero_cartao)
        )

