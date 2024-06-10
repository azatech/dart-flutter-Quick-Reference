## Greedy Algorithm

### Overview of Greedy Algorithm
A greedy algorithm is an approach for solving problems by making the locally optimal choice at each step with the hope of finding the global optimum. 
The main idea is to build up a solution piece by piece, always choosing the next piece that offers the most immediate benefit.

Example
Input: Coins = [1, 2, 5], Amount = 11
Output: 3 (11 = 5 + 5 + 1)

```
int minCoins(List<int> coins, int amount) {
  // Sort the coins in descending order
  coins.sort((a, b) => b.compareTo(a));
  
  int count = 0;
  int remainingAmount = amount;

  for (int coin in coins) {
    if (remainingAmount == 0) break;
    count += remainingAmount ~/ coin; // 11 / 5 = 2
    remainingAmount %= coin;
  }

  // If the remaining amount is not zero, it's not possible to make the amount with given coins
  return remainingAmount == 0 ? count : -1;
}
```
