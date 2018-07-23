shuffleRandom <- function(deck) {
  sample(deck)
}

simpleRandomCuts <- function(min=20, max=40) {
  function (deck) {
    n <- round(runif(1)*(max - min))
    result <- deck
    
    for(i in 1:n) {
      points <- sort(ceiling(runif(2)*(max - min)))
      firstHalf <- result[points[1]:points[2]]
      secondHalf <- result[-(points[1]:points[2])]
      
      if (i %% 2 == 0) {
        result <- c(firstHalf, secondHalf)
      } else {
        result <- c(secondHalf, firstHalf)
      }
    }
    
    result
  }
}

prepareDeck <- function(deck) {
  lands <- deck[deck < 10]
  cards <- deck[deck >= 10]
  
  suppressWarnings({
    lands <- as.vector(do.call(cbind, split(lands, 1:3)))
    cards <- as.vector(do.call(cbind, split(cards, 1:6)))
    pairs <- split(cards, 1:(length(cards)/2))
  })
  
  result <- c()
  
  for (i in 1:min(length(lands), length(pairs))) {
    result <- c(result, lands[i], pairs[[i]])
  }
  
  result
}

prepareShuffle <- function(shuffle) {
  function(deck) {
    shuffle(prepareDeck(deck))
  }
}