shuffleRandom <- function(deck) {
  sample(deck)
}

reorderBlocks <- function(i, firstHalf, secondHalf) {
  if (i %% 2 == 0) {
    result <- c(firstHalf, secondHalf)
  } else {
    result <- c(secondHalf, firstHalf)
  }
  
  result
}

interleaveBlock <- function(i, firstHalf, secondHalf) {
  separations <- rgeom(length(firstHalf), 0.4)
  result <- c()
  lastIndex <- 1
  
  for (j in 1:length(firstHalf)) {
    newIndex <- lastIndex + separations[j]
    result <- c(result, firstHalf[[j]], secondHalf[lastIndex:newIndex])
    lastIndex <- newIndex + 1
  }
  
  result <- na.omit(result)
  result
}

middleShuffle <- function(shuffleFn, minCards=20, maxCards=40) {
  function (deck, n = 40) {
    result <- deck
    
    for(i in 1:n) {
      points <- sort(ceiling(runif(2, -5, 5))) + c(minCards, maxCards)
      firstHalf <- result[points[1]:points[2]]
      secondHalf <- result[-(points[1]:points[2])]
      
      result <- shuffleFn(i, firstHalf, secondHalf)
    }
    
    attributes(result) <- NULL
    result
  }  
}

simpleRandomCuts <- function(minCards=20, maxCards=40) {
  middleShuffle(reorderBlocks, minCards, maxCards)
}

interleaved <- function(minCards=20, maxCards=40) {
  middleShuffle(interleaveBlock, minCards, maxCards)
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