## Sliding Window Technique

### Overview of Sliding Window Technique

The sliding window technique is a method used to efficiently solve problems involving subarrays or
substrings. It involves maintaining a window that slides over the input data to calculate or find a
desired property within the window. This technique is particularly useful for problems involving:

Finding the maximum or minimum sum of a subarray of fixed size.
Finding a subarray or substring that meets certain criteria.
Solving problems with overlapping subproblems.

#### Leetcode: 3 Longest Substring Without Repeating Characters

Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.

```
class Solution {
  int lengthOfLongestSubstring(String s) {
    var answer = 0;
    var left = 0;
    var right = 0;
    var set = <String>{};

    while (right < s.length) {
      final c = s[right];
      if (!set.contains(c)) {
        set.add(c);
        answer = max(right - left + 1, answer);
        right++;
      } else {
        set.remove(s[left]);
        left++;
      }
    }

    return answer;
  }
}
```

#### Leetcode: 594 Longest Harmonious Subsequence

Input: nums = [1,3,2,2,5,2,3,7]
Output: 5
Explanation: The longest harmonious subsequence is [3,2,2,2,3].

#### Swift code:

```
class Solution {
    func findLHS(_ nums: [Int]) -> Int {
        if (Set(nums).count == 1) {
            return 0
        }
        let sorted = nums.sorted()
        var left = 0
        var right = 0
        var result = 0
        
        while (right < sorted.count) {
            let diff = sorted[right] - sorted[left]
            
            if diff == 1 {
                result = max(result, right - left + 1)
            }
            
            if diff <= 1 {
                right += 1
            } else {
                left += 1
            }
        }
        return result
    }
}
```
