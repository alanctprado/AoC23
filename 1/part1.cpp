#include <bits/stdc++.h>

using namespace std;

int main() {
  ios_base::sync_with_stdio(0); cin.tie(0);
  int sum = 0;
  string s;
  while(getline(cin, s)) {
    string r = "0";
    for (int i = 0; i < s.length(); i++) if (isdigit(s[i])) {
      r += s[i];
      break;
    }
    for (int i = s.length() - 1; i >= 0; i--) if (isdigit(s[i])) {
      r += s[i];
      break;
    }
    sum += stoi(r);
  }
  cout << sum << endl;
	exit(0);
}
