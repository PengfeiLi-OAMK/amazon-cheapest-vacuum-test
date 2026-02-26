import re


class AmazonValidationLib:
    def verify_prices_are_in_ascending_order(self, price_texts):
        """
        Receives a list of price strings (e.g., ['$15.99', '$18.50']),
        cleans them, converts to floats, and asserts they are sorted ascending.
        """
        if not price_texts:
            raise AssertionError("Price list is empty.")
        prices=[]
        
        for price_text in price_texts:
            cleaned_price=re.sub(r'[^\d.]', '', price_text)
            if cleaned_price:
                try:
                    prices.append(float(cleaned_price))
                except ValueError:
                    raise AssertionError(f"Invalid price format: '{price_text}'")
        if not prices:
            raise AssertionError("No valid prices found.")
        if prices != sorted(prices):
            raise AssertionError(f"Prices are not sorted in ascending order:Raw: {prices}, Sorted: {sorted(prices)}")
        print(f"Validation Passed: {prices}")