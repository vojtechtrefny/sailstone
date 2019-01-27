import pyotherside


class CardsCache(dict):
    pass


class Card(object):

    def __init__(self):
        self.id = "EX1_001"
        self.name = "Lightwarden"
        self.preview = "https://art.hearthstonejson.com/v1/render/latest/enUS/256x/EX1_001.png"
        self.image = "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/EX1_001.png"
        self.text = "Whenever a character is healed, gain +2 Attack."
        self.stats = "1/2"
        self.type = "Minion"


def get_random_card():
    card = Card()
    cards_cache[card.name] = card
    return Card()


def get_card(card_name):
    if card_name in cards_cache.keys():
        return cards_cache[card_name]
    else:
        raise NotImplementedError()  # FIXME


cards_cache = CardsCache()
