{-
Construct a complete binary tree

A complete binary tree with height H is defined as follows:

The levels 1,2,3,...,H-1 contain the maximum number of nodes (i.e 2**(i-1) at the level i)
In level H, which may contain less than the maximum possible number of nodes, all the nodes are "left-adjusted". This means that in a levelorder tree traversal all internal nodes come first, the leaves come second, and empty successors (the nil's which are not really nodes!) come last.
Particularly, complete binary trees are used as data structures (or addressing schemes) for heaps.

We can assign an address number to each node in a complete binary tree by enumerating the nodes in level-order, starting at the root with number 1. For every node X with address A the following property holds: The address of X's left and right successors are 2*A and 2*A+1, respectively, if they exist. This fact can be used to elegantly construct a complete binary tree structure.

Write a predicate complete_binary_tree/2.
-}

data Tree a = Empty | Branch a (Tree a) (Tree a)
              deriving (Show, Eq)

completeBinaryTree :: Int -> Tree Int
completeBinaryTree nb 
    | nb >= 0 = expand nb (Branch 1 Empty Empty)
    | otherwise = Empty

expand :: Int -> Tree Int -> Tree Int
expand nb (Branch a Empty Empty)
    | nb > 2 * a + 1 = Branch a (expand nb (Branch (2*a) Empty Empty)) 
                                (expand nb (Branch (2*a+1) Empty Empty))
    | nb == 2 * a = Branch a (Branch (2*a) Empty Empty) Empty
    | otherwise = Branch a Empty Empty
expand nb (Branch a l r) = Branch a (expand nb l) (expand nb r)

-- Extra  
isCompleteBinaryTree :: Tree a -> Bool
isCompleteBinaryTree Empty = True
isCompleteBinaryTree (Branch _ l r) 
    | (depth r) > (depth l) = False
    | (depth l) > (depth r) + 1 = False
    | otherwise = isCompleteBinaryTree l && isCompleteBinaryTree r

depth :: Tree a -> Int
depth Empty = 0
depth (Branch _ l r) = 1 + max (depth l) (depth r)
