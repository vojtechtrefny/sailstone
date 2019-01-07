import pyotherside

class Card(object):

    def __init__(self):
        self.id = "EX1_001"
        self.name = "Lightwarden"
        self.image = "https://art.hearthstonejson.com/v1/render/latest/enUS/512x/EX1_001.png"


def get_random_card():
    return Card()
