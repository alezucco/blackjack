#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'playerDone', => @playerDone()
    @get('playerHand').on 'checkScore', => @checkBust()



  checkBust:->

    alert 'You lost ALL YOUR MONEEEY' if @get('playerHand').scores()[0]>21
    window.location.reload()
    #@set 'playerHand', deck.dealPlayer()
    #@set 'dealerHand', deck.dealDealer()
  checkScore:->
    alert '$$$$$$$$$$$$' if @get('dealerHand').scores()[0]>21 or @get('dealerHand').scores()[0]<@get('playerHand').scores()[0]
    #@set 'playerHand', deck.dealPlayer()
    #@set 'dealerHand', deck.dealDealer()
    window.location.reload()
    #window.location()
    alert 'You lost ALL YOUR MONEEEY' if @get('dealerHand').scores()[0]>@get('playerHand').scores()[0]
    window.location.reload()
  playerDone:->
    @get('dealerHand').models[0].flip()
    @get('dealerHand').hit()  while @get('dealerHand').scores()[0]<17
    @checkScore()
