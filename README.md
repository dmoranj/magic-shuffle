# Shuffle Analysis

## Overview

This project aims to experiment on the effect of the different ways of shuffling in the final distribution of cards in the hand, and to check whether different preparation methods before shuffling aid to improve the results. We will also try to investigate how "fair" each shuffle is, i.e.: to what extent the shuffle mixes the cards properly. 

The hand analysis will be applyed to a [Magic The Gathering](https://magic.wizards.com/en) simulation deck (as the apparent lack of randomness in certain games was the driving force behind this project; e.g.: the unexplained tendency of lands to group together... and out of your hand). Since the only interest of this project is in the effects of shuffling, cards will be simply represented as two digit numbers, the first digit representing the color, and the second one being the card ID. Lands will be represented as one digit numbers, its color matching the first digit in spell cards. We will use this representation to calculate the mean number of unplayable cards for multicolor decks, and the mean number of turns before all colors are playable (for each kind of shuffle).

In order to achieve these goals, several shuffling methods will be implemented. These methods reflect some of the different ways of shuffling actually observed in practice. Obviously, this enumeration doesn't intend to be exhaustive. The following shuffles are currently implemented:

* **Random Shuffle**: we will use a random permutation of the cards as the control shuffle, using R's base *sample()* function.

* **SimpleRandomCuts**: each iteration of this shuffle consists on drawing a block of cards from the center of the deck, and then closing the cut randomly in the upper or in the lower side of the deck. This process is repeated *N* times. The block of cards is defined by two values (the fisrt and last cards of the block), to which a small error is randomly added, to account for the expected lack of accuracy of the human selection.

* **Interleave Shuffle**: this shuffle draws a block of cards from the center of the deck, as the previous one, but it then interleaves the cards in these block with the cards in the upper part of the deck. Since this action is expected to be highly non-uniform, the separation between each card in the drawn block (the number of the remaining deck cards between each of the drawn cards) is drawn from a geometric distribution (whose parameters were tuned manually).

