#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'playerDone', => @playerDone()
    @get('playerHand').on 'checkScore', => @checkBust()


  playerScores:->
    if @get('playerHand').scores()[1]<22 then @get('playerHand').scores()[1]
    else @get('playerHand').scores()[0]

  dealerScores:->
    if @get('dealerHand').scores()[1]<22 then @get('dealerHand').scores()[1]
    else @get('dealerHand').scores()[0]

  checkBust:->

    $('body').append('<img src= "img/giphy.gif" class="lose"><img>') if @playerScores()>21
    setTimeout (->
        window.location.reload()
        return
    ), 5000
  checkScore:->
    $('body').append('<img src= "img/win.gif" class="win"><img>') if @dealerScores()>21 or @dealerScores()<@playerScores()

    setTimeout (->
        window.location.reload()
        return
    ), 5000
    $('body').append('<img src= "img/giphy.gif" class="lose"><img>') if @dealerScores()>@playerScores() and @dealerScores()<22
    setTimeout (->
        window.location.reload()
        return
    ), 5000
  playerDone:->
    @get('dealerHand').models[0].flip()
    @get('dealerHand').hit()  while @dealerScores()<17
    @checkScore()
