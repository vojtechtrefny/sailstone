import pyotherside

import json
import os
import random
import urllib.parse
import urllib.request
import threading


DATA_FOLDER = os.path.expandvars("$HOME/.local/share/harbour-sailstone")


class API(object):

    single_card_endpoint = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/{name}"
    search_card_endpoint = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/search/{name}?collectible={collectible}"
    cards_by_type_endpoint = "https://omgvamp-hearthstone-v1.p.mashape.com/cards/types/{type}?collectible={collectible}"

    def __init__(self):
        self._api_key = None

    def _api_call(self, url):
        req = urllib.request.Request(url)
        req.add_header("X-Mashape-Key", self.api_key)
        req.add_header("Accept", "application/json")

        return urllib.request.urlopen(req).read().decode()

    @property
    def api_key(self):
        if self._api_key is None:
            api_key_path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "api.key")
            if not os.path.exists(api_key_path):
                raise RuntimeError("API key file not found.")

            with open(api_key_path, "r") as f:
                self._api_key = f.read().strip()

        return self._api_key

    def get_single_card(self, card_name):
        card_name = urllib.parse.quote(card_name)  # safe card name for the url

        raw_data = self._api_call(self.single_card_endpoint.format(name=card_name))

        card_data = json.loads(raw_data)

        if len(card_data) != 1:
            raise RuntimeError("Failed to get single card data")

        return Card(**card_data[0])

    def search_cards(self, card_name, collectible=True):
        card_name = urllib.parse.quote(card_name)  # safe card name for the url

        try:
            raw_data = self._api_call(self.search_card_endpoint.format(name=card_name,
                                                                       collectible="1" if collectible else "0"))
        except urllib.error.HTTPError:
            # unfortunately this also means "no cards found"
            return []

        cards_data = json.loads(raw_data)

        return [Card(**c) for c in cards_data]

    def get_random_card(self):
        raw_data = self._api_call(self.cards_by_type_endpoint.format(type="Minion", collectible="1"))

        cards_data = json.loads(raw_data)

        random_card = random.choice(cards_data)

        return Card(**random_card)


class CardsCache(dict):
    pass


class Card(object):

    image_api = "https://art.hearthstonejson.com/v1/render/latest/enUS/{resultion}/{card_id}.png"

    def __init__(self, **kwargs):
        self.id = kwargs.get("cardId", "")
        self.name = kwargs.get("name", "")
        self.text = kwargs.get("text", "")
        self.type = kwargs.get("type", "")

        self.preview = self.image_api.format(resultion="256x", card_id=self.id)
        self.image = self.image_api.format(resultion="512x", card_id=self.id)

        self.stats = "%s/%s" % (kwargs.get("attack", ""), kwargs.get("health", ""))


def get_random_card():
    card = cards_api.get_random_card()
    cards_cache[card.name] = card
    return card


def get_card(card_name):
    if card_name in cards_cache.keys():
        return cards_cache[card_name]
    else:
        card = cards_api.get_single_card(card_name)
        cards_cache[card.name] = card
        return card


def _search_fn(card_name):
    cards = cards_api.search_cards(card_name)

    for card in cards:
        cards_cache[card.name] = card

    pyotherside.send("searching_finished", cards)


def search_card(card_name):
    thread = threading.Thread(target=_search_fn, args=(card_name,))
    thread.start()
    thread.join()


def _favourites_fn():
    favourites = []

    if not os.path.exists(os.path.join(DATA_FOLDER, "favourites.json")):
        pyotherside.send("favourites_finished", favourites)

    with open(os.path.join(DATA_FOLDER, "favourites.json"), "r") as f:
        data = f.read()
        favourites = json.loads(data)

    pyotherside.send("favourites_finished", [get_card(f) for f in favourites])


def get_favourites():
    thread = threading.Thread(target=_favourites_fn)
    thread.start()
    thread.join()


def is_in_favourites(card_name):
    with open(os.path.join(DATA_FOLDER, "favourites.json"), "r") as f:
        data = f.read()
        favourites = json.loads(data)

        return card_name in favourites


def add_to_favourites(card_name):
    favourites = []

    with open(os.path.join(DATA_FOLDER, "favourites.json"), "r") as f:
        data = f.read()
        if data:
            favourites = json.loads(data)

    with open(os.path.join(DATA_FOLDER, "favourites.json"), "w+") as f:
        if card_name not in favourites:
            favourites.append(card_name)

        f.write(json.dumps(favourites))


def remove_from_favourites(card_name):
    favourites = []

    with open(os.path.join(DATA_FOLDER, "favourites.json"), "r") as f:
        data = f.read()
        if data:
            favourites = json.loads(data)

    with open(os.path.join(DATA_FOLDER, "favourites.json"), "w+") as f:
        if card_name in favourites:
            favourites.remove(card_name)

        f.write(json.dumps(favourites))


cards_cache = CardsCache()
cards_api = API()
