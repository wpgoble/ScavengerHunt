# Regex Scavenger Hunt - Challenges

Use grep and find commands to complete these challenges. All sample files are in the `sample_files/` directory.

---

## EASY LEVEL

### Challenge 1: Find Comments
**Task:** Find all lines containing the word "TODO"

**Command to try:**
```bash
grep "TODO" sample_files/*
```

**Expected result:** 4 lines from different files marking tasks that need to be done

---

### Challenge 2: Find All Java Files
**Task:** Use `find` to locate all Java source files

**Command to try:**
```bash
find sample_files -name "*.java"
```

**Expected result:** 3 Java files (Main.java, Calculator.java, StringUtils.java)

---

### Challenge 3: Find All Python Files
**Task:** Use `find` to locate all Python source files

**Command to try:**
```bash
find sample_files -name "*.py"
```

**Expected result:** 2 Python files (data_processor.py, text_utils.py)

---

### Challenge 4: Find Lines with Numbers
**Task:** Find all lines containing at least one digit

**Command to try:**
```bash
grep "[0-9]" sample_files/*
```

**Expected result:** Many lines - version numbers, array indices, calculations, etc.

---

### Challenge 5: Find FIXME Comments
**Task:** Find all lines marked with "FIXME" (similar to TODO)

**Command to try:**
```bash
grep "FIXME" sample_files/*
```

**Expected result:** 5 lines across multiple files

---

### Challenge 6: Find All Imports
**Task:** Find all import statements (both Java and Python)

**Command to try:**
```bash
grep "import" sample_files/*
```

**Expected result:** 10 import statements

---

## INTERMEDIATE LEVEL

### Challenge 7: Find Lines Starting with "public"
**Task:** Find all lines that begin with the keyword "public" (Java access modifier)

**Command to try:**
```bash
grep "^public" sample_files/*.java
```

**Expected result:** 4 lines with public methods/classes

---

### Challenge 8: Find Private Methods
**Task:** Find all lines starting with "private" (optional whitespace allowed)

**Command to try:**
```bash
grep "^\s*private" sample_files/*.java
```

**Expected result:** 2 private methods

---

### Challenge 9: Find All Comments (Java and Python)
**Task:** Find lines that are Java comments (//) OR Python comments (#)

**Hint:** Use extended grep with the `-E` flag for alternation

**Command to try:**
```bash
grep -E "//|#" sample_files/*
```

**Expected result:** Many lines - all comments in the codebase

---

### Challenge 10: Find Variable Assignments
**Task:** Find lines with variable assignments (look for the = operator)

**Hint:** You need to find lines containing a variable name followed by = (with optional spaces)

**Command to try:**
```bash
grep -E "[a-zA-Z_][a-zA-Z0-9_]* *=" sample_files/*
```

**Expected result:** Variable declarations and assignments across all files

---

### Challenge 11: Find Method/Function Definitions
**Task:** Find all method and function definitions (both Java and Python)

**Hint:** Look for patterns like "public void method_name" (Java) or "def function_name" (Python)

**Command to try:**
```bash
grep -E "public|private|def " sample_files/*
```

**Expected result:** All method and function definitions

---

### Challenge 12: Find Lines with Version Numbers
**Task:** Find all version strings (format: digits.digits.digits like "1.2.3")

**Hint:** Use quantifiers to match exactly 2-3 digit groups separated by dots

**Command to try:**
```bash
grep -E "[0-9]+\.[0-9]+\.[0-9]+" sample_files/*
```

**Expected result:** 3 version strings found

---

### Challenge 13: Find Configuration Key-Value Pairs
**Task:** Find all lines in config.txt with key=value format

**Hint:** Look for alphanumeric characters, equals sign, and values

**Command to try:**
```bash
grep -E "^[a-zA-Z_][a-zA-Z0-9_]*=" sample_files/config.txt
```

**Expected result:** 16 configuration lines (excluding comments and blank lines)

---

### Challenge 14: Find Strings in Quotes
**Task:** Find all lines containing text within double quotes

**Hint:** Match an opening quote, anything inside, then a closing quote

**Command to try:**
```bash
grep "\".*\"" sample_files/*
```

**Expected result:** Many lines with string literals

---

## INTERMEDIATE-ADVANCED LEVEL

### Challenge 15: Find Python Function Definitions Only
**Task:** Find only lines with "def" in Python files (excluding comments)

**Hint:** Use word boundary or start of line anchor

**Command to try:**
```bash
grep "^def " sample_files/*.py
```

**Expected result:** 8 function definitions (including class methods)

---

### Challenge 16: Find URLs
**Task:** Find all HTTP(S) URLs in the codebase

**Hint:** Match "http" or "https", then "://", then any non-whitespace characters

**Command to try:**
```bash
grep -E "https?://[^ ]+" sample_files/*
```

**Expected result:** 1 URL (https://api.example.com)

---

### Challenge 17: Find Email-like Patterns
**Task:** Find all email-like patterns in the codebase

**Hint:** Look for text with @ and . in it

**Command to try:**
```bash
grep -E "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" sample_files/*
```

**Expected result:** 2 email patterns

---

### Challenge 18: Find Lines with Both Letters and Numbers
**Task:** Find lines containing both alphabetic characters AND numeric digits

**Hint:** This requires lookahead or matching a pattern that has both. Try finding lines with "VERSION" or similar version-related content.

**Command to try:**
```bash
grep -E "[a-zA-Z].*[0-9]|[0-9].*[a-zA-Z]" sample_files/*
```

**Expected result:** Many lines with mixed alphanumeric content

---

### Challenge 19: Find Hex Color Codes
**Task:** Find all hex color codes (format: #RRGGBB)

**Command to try:**
```bash
grep -E "#[0-9A-Fa-f]{6}" sample_files/*
```

**Expected result:** 1 hex color code

---

### Challenge 20: Find Camel Case Words
**Task:** Find words in camelCase or PascalCase format

**Hint:** Match a lowercase letter followed by an uppercase letter

**Command to try:**
```bash
grep -E "[a-z][A-Z]" sample_files/*
```

**Expected result:** Many lines (class names, method names, variable names)

---

### Challenge 21: Find Lines with Escaped Characters
**Task:** Find lines that reference escaped characters like \n, \t, \d

**Command to try:**
```bash
grep -E "\\\\[ntrdsw]" sample_files/*
```

**Expected result:** 2-3 lines with regex patterns containing escapes

---

### Challenge 22: Advanced - Find Comment Blocks
**Task:** Find all lines that start with optional whitespace followed by a comment marker

**Hint:** Use anchors and character classes for optional whitespace

**Command to try:**
```bash
grep -E "^\s*(//|#)" sample_files/*
```

**Expected result:** All comment-only lines

---
## OTHER CHALLENGES

### Challenge 23: Find all function definitions in Go files
```bash
grep "^func" sample_files/*.go
```
---
### Challenge 24: Find all let bindings in OCaml
```bash
grep "let " sample_files/*.ml
```
---
### Challenge 25: Find all type annotations
```bash
grep -E ":\s*[A-Z][a-zA-Z0-9]*" sample_files/*.ml
```
---
### Challenge 26: Find all channel operations 
```bash
grep "chan" sample_files/*.go
```
---
### Challenge 27: Find all version constants across all languages
```bash
grep -rE "VERSION|version|:=|=" sample_files/ | grep -E "[0-9]+\.[0-9]+\.[0-9]+"
```
---
### Challenge 28: Find all Lua function definitions
```bash
grep "^function" sample_files/*.lua
```
---
### Challenge 29: Find all Vimscript functions 
```bash
grep -E "^function|^command" sample_files/*.vim
```
---
### Challenge 30: Find all shell functions
```bash
grep -E "^\w+\(\)" sample_files/*.sh
```
---
### Challenge 31: Find all readonly variables in bash
```bash
grep "readonly" sample_files/*.sh
```
---
### Challenge 32: Find all autocommands in Vim
```bash
grep "autocmd" sample_files/*.vim
```
---
### Challenge 33: Find version strings in all new files
```bash
grep -E "VERSION|version|v[0-9]+" sample_files/{*.lua,*.vim,*.sh}
```
---
### Challenge 34: Count TODO items per language
```bash
for ext in lua vim sh; do echo "$ext: $(grep -c "TODO" sample_files/*.$ext)"; done
```
---

### Challenge 35: Find all logging statements in bash
```bash
grep "log_\(info\|error\|warn\|debug\)" sample_files/*.sh
```
---
# BONUS CHALLENGES

### Bonus 1: Find Files Modified Today
**Task:** Use find to locate files based on modification time

**Command to try:**
```bash
find sample_files -type f -mtime 0
```

**Expected result:** Depends on current date

---

### Bonus 2: Count Matching Lines
**Task:** How many TODO items are in the entire codebase?

**Hint:** Use grep with the `-c` flag to count

**Command to try:**
```bash
grep -r "TODO" sample_files | wc -l
```

**Expected result:** 4

---

### Bonus 3: Find and Count
**Task:** How many Python files contain the word "import"?

**Command to try:**
```bash
find sample_files -name "*.py" -exec grep -l "import" {} \;
```

**Expected result:** 2 Python files

---

### Bonus 4: Nested Pattern Search
**Task:** Find all lines with "return" statements

**Command to try:**
```bash
grep "return" sample_files/*.java sample_files/*.py
```

**Expected result:** Multiple return statements

---

## Tips for Success

1. **Use `-E` flag** for extended regex features (alternation with |, quantifiers +?, etc.)
2. **Use wildcards** like `sample_files/*` to search all files
3. **Refine your search** if you get too many results - add more specific patterns
4. **Test incrementally** - start with simpler patterns and build up
5. **Use quotes** around your pattern to prevent shell interpretation
6. **Check the file** visually if unsure: `cat sample_files/filename`

---
