import json
import csv
from datetime import datetime

# TODO: Add logging functionality
VERSION = "2.1.3"

class DataProcessor:
    """
    Handles processing of data files.
    FIXME: Memory usage is too high for large datasets
    """
    
    def __init__(self, filename):
        # TODO: Validate filename
        self.filename = filename
        self.data = []
        self.created_date = datetime.now()
    
    def load_json(self):
        """Load data from JSON file"""
        with open(self.filename, 'r') as f:
            self.data = json.load(f)
        return self.data
    
    def load_csv(self):
        """Load data from CSV file"""
        with open(self.filename, 'r') as f:
            reader = csv.DictReader(f)
            self.data = list(reader)
        return self.data
    
    def filter_by_date(self, start_date, end_date):
        """
        Filter records by date range.
        NOTE: Assumes date format is ISO 8601
        """
        filtered = []
        for record in self.data:
            if 'date' in record:
                record_date = datetime.fromisoformat(record['date'])
                if start_date <= record_date <= end_date:
                    filtered.append(record)
        return filtered
    
    def count_records(self):
        """Return the number of records"""
        return len(self.data)

def process_line(line):
    """Process a single line of text"""
    # FIXME: This regex is too broad
    import re
    pattern = r'[A-Za-z0-9]+'
    matches = re.findall(pattern, line)
    return matches

def validate_email(email):
    """Basic email validation"""
    import re
    # TODO: Make this more robust
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return re.match(pattern, email) is not None

def extract_numbers(text):
    """Extract all numbers from text"""
    import re
    pattern = r'\d+'
    return re.findall(pattern, text)

def is_valid_variable_name(name):
    """Check if string is a valid Python variable name"""
    import re
    pattern = r'^[a-zA-Z_][a-zA-Z0-9_]*$'
    return re.match(pattern, name) is not None