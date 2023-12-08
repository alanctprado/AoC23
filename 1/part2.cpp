#include <bits/stdc++.h>

using namespace std;

vector<string> digits = {"one", "two", "three", "four", "five", "six", "seven",
                         "eight", "nine"};

int main() {
  ios_base::sync_with_stdio(0); cin.tie(0);
  int sum = 0;
  string s;
  while(getline(cin, s)) {
    string r = "0";
    for (int i = 0; i < s.length(); i++) {
      if (isdigit(s[i])) { r += s[i]; break; }
      bool b = 0;
      for (int j = 0; j < digits.size(); j++) {
        if (s.length() - i >= digits[j].length()) {
          if (!digits[j].compare(s.substr(i, digits[j].length()))) {
            r += j + 1 + '0';
            b = 1;
          }
        }
      }
      if (b) break;
    }
    for (int i = s.length(); i >= 0; i--) {
      if (isdigit(s[i])) { r += s[i]; break; }
      bool b = 0;
      for (int j = 0; j < digits.size(); j++) {
        if (i + 1 >= digits[j].length()) {
          if (!digits[j].compare(s.substr(i - digits[j].length() + 1, digits[j].length()))) {
            r += j + 1 + '0';
            b = 1;
          }
        }
      }
      if (b) break;
    }
    sum += stoi(r);
  }
  cout << sum << endl;
	exit(0);
}
