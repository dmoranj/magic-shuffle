generateBasicDeck <- function(lands, standardCards) {
  lands <- as.vector(sapply(lands, rep, ceiling(20/length(lands))))
  cards <- as.vector(sapply(standardCards, rep, 4))
  deck <- c(lands, cards)
  deck
}

drawNHands <- function(deck, n, shuffleFn=shuffleRandom) {
  hands <- t(replicate(n, head(shuffleFn(deck), 7)))
  hands
}

analyzeHand <- function(hand) {
  nLands <- sum(hand < 6)
  landTypes <- sort(unique(hand[hand < 6]))
  cardTypes <- sort(unique(floor(hand[hand > 6]/10)))
  
  nLandTypes <- length(landTypes)
  nCardTypes <- length(cardTypes)
  
  playableCards <- sum(floor(hand[hand > 6]/10) %in% landTypes)
  
  data.frame(
    nLands = nLands,
    nLandTypes = nLandTypes,
    nCardTypes = nCardTypes,
    playableCards = playableCards)
}

analyzeHands <- function(hands) {
  do.call(rbind, apply(hands, 1, analyzeHand))
}