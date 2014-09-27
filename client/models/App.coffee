#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'playerDone', => @playerDone()
    @get('playerHand').on 'checkScore', => @checkBust()



  checkBust:->

    $('body').append('<img src= "img/giphy.gif" class="lose"><img>') if @get('playerHand').scores()[0]>21
    setTimeout (->
        window.location.reload()
        return
    ), 5000
  checkScore:->
    $('body').append('<img src= "img/win.gif" class="win"><img>') if @get('dealerHand').scores()[0]>21 or @get('dealerHand').scores()[0]<@get('playerHand').scores()[0]

    setTimeout (->
        window.location.reload()
        return
    ), 5000
    $('body').append('<img src= "img/giphy.gif" class="lose"><img>') if @get('dealerHand').scores()[0]>@get('playerHand').scores()[0] and @get('dealerHand').scores()[0]<22
    setTimeout (->
        window.location.reload()
        return
    ), 5000
  playerDone:->
    @get('dealerHand').models[0].flip()
    @get('dealerHand').hit()  while @get('dealerHand').scores()[0]<17
    @checkScore()
