"""
Utility functions for string manipulation and validation.
TODO: Add comprehensive docstrings to all functions
"""

import re
from typing import List, Dict, Optional

class TextUtils:
    """
    Collection of text utility functions.
    NOTE: All methods are static
    """
    
    @staticmethod
    def split_camel_case(text):
        """
        Splits camelCase or PascalCase text.
        FIXME: Doesn't handle acronyms well
        """
        pattern = r'([A-Z][a-z]+)'
        return re.findall(pattern, text)
    
    @staticmethod
    def find_urls(text):
        """Extract URLs from text"""
        # TODO: Support more URL schemes
        pattern = r'https?://[^\s]+'
        return re.findall(pattern, text)
    
    @staticmethod
    def find_hashtags(text):
        """Extract hashtags from text"""
        pattern = r'#[a-zA-Z0-9_]+'
        return re.findall(pattern, text)
    
    @staticmethod
    def anonymize_email(email):
        """Replace email with asterisks"""
        # NOTE: Simple implementation
        parts = email.split('@')
        if len(parts) == 2:
            return f"{parts[0][0]}***@{parts[1]}"
        return email

def count_lines(filename):
    """Count lines in a file"""
    with open(filename, 'r') as f:
        return len(f.readlines())

def find_duplicates(items: List[str]) -> List[str]:
    """Find duplicate items in a list"""
    # TODO: Optimize for large lists
    seen = set()
    duplicates = []
    for item in items:
        if item in seen and item not in duplicates:
            duplicates.append(item)
        seen.add(item)
    return duplicates

def format_phone_number(phone):
    """
    Format phone number to standard format.
    FIXME: Only works for US numbers
    """
    # Remove non-digits
    digits = re.sub(r'\D', '', phone)
    if len(digits) == 10:
        return f"({digits[:3]}) {digits[3:6]}-{digits[6:]}"
    return phone

def is_hex_color(color):
    """Check if string is valid hex color"""
    pattern = r'^#[0-9A-Fa-f]{6}$'
    return re.match(pattern, color) is not None

class Config:
    """Configuration handler"""
    
    def __init__(self, config_file):
        self.config_file = config_file
        self.settings = {}
        self.load_config()
    
    def load_config(self):
        """Load configuration from file"""
        # TODO: Add error handling
        with open(self.config_file, 'r') as f:
            for line in f:
                if '=' in line and not line.startswith('#'):
                    key, value = line.strip().split('=', 1)
                    self.settings[key] = value