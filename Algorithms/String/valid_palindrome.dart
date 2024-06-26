/// https://leetcode.com/problems/valid-palindrome/?envType=study-plan-v2&envId=top-interview-150
// ignore_for_file: prefer_const_declarations

/*
Example 1:
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.

Example 2:
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.

Example 3:
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.
 */

void main() {
  final s = 'A man, a plan, a ccanal: Panama';
  final sol = Solution().isPalindrome(s);
  print(sol);
}

class Solution {
  bool isPalindrome(String s) {
    if (s.trim().isEmpty) return true;

    final processed = processString(s);
    final lenInd = processed.length - 1;
    final halfWay = lenInd / 2;
    var isEqual = true;

    for (var i = 0; i < halfWay; i++) {
      final end = processed[lenInd - i];
      final start = processed[i];
      isEqual = start == end;
      if (!isEqual) return false;
    }
    return isEqual;
  }

  String processString(String input) {
    String res = input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return res;
  }
}
