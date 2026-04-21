#include <iostream>
#include <vector>

using namespace std;

int maxSubSum1(const vector<int> & a);
int maxSubSum2(const vector<int> & a);
int maxSubSum3(const vector<int> & a);
int maxSubSum4(const vector<int> & a);
int maxSumRec( const vector<int>& a, int left, int right);
int max3(int x, int y, int z);

int main()
{



}

// Cubic maximum contiguous sum algorithm
int maxSubSum1(const vector<int> & a)
{
  int maxSum = 0;

  for (int i = 0; i < a.size(); i++)
  {
    for (int j = i; j < a.size(); j++)
    {
      int thisSum = 0;
      for (int k = i; k <= j; k++)
         thisSum += a[k];

      if (thisSum > maxSum)
         maxSum = thisSum;
    }
  }

  return maxSum;
}

// Quadratic maximum contiguous sum algorithm
int maxSubSum2(const vector<int> & a)
{
  int maxSum = 0;

  for (int i = 0; i < a.size(); i++)
  {
    int thisSum = 0;
    for (int j = i; j < a.size(); j++)
    {
      thisSum += a[j];

      if (thisSum > maxSum)
         maxSum = thisSum;
    }
  }

  return maxSum;
}

// Recursive maximum contiguous sum algorithm
int maxSubSum3(const vector<int> & a)
{
   return maxSumRec(a, 0, a.size() - 1);
}

// Used by driver fucntion above, this one is called recursively
int maxSumRec( const vector<int>& a, int left, int right)
{
   if (left == right)		// base case
     if (a[left] > 0)
        return a[left];
     else
        return 0;

   int center = (left + right) / 2;
   int maxLeftSum = maxSumRec(a, left, center);		// recursive call
   int maxRightSum = maxSumRec(a, center+1, right);	// recursive call

   int maxLeftBorderSum = 0, leftBorderSum = 0;
   for (int i = center; i >= left; --i)
   {
      leftBorderSum += a[i];
      if (leftBorderSum > maxLeftBorderSum)
         maxLeftBorderSum = leftBorderSum;
   }

   int maxRightBorderSum = 0, rightBorderSum = 0;
   for (int j = center+1; j <= right; ++j)
   {
      rightBorderSum += a[j];
      if (rightBorderSum > maxRightBorderSum)
         maxRightBorderSum = rightBorderSum;
   }

   return max3(maxLeftSum, maxRightSum, 
		maxLeftBorderSum + maxRightBorderSum);
}

int max3(int x, int y, int z)
{
   int max = x;
   if (y > max)		max = y;
   if (z > max)		max = z;
   return max;
}



// Linear-time maximum contiguous subsequence sum algorithm
int maxSubSum4(const vector<int> & a)
{
  int maxSum = 0, thisSum = 0;

  for (int i = 0; i < a.size(); i++)
  {
    thisSum += a[i];

    if (thisSum > maxSum)
       maxSum = thisSum;
    else if (thisSum < 0)
       thisSum = 0;
  }

  return maxSum;
}



