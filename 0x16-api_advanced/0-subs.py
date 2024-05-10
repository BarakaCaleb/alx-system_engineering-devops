#!/usr/bin/python3

def number_of_subscribers(subreddit):
    """Return the number of subscribers for a given subreddit"""
    import requests
    import json
    url = "https://www.reddit.com/r/{}/about.json".format(subreddit)
    headers = {'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'}
    response = requests.get(url, headers=headers)
    if response.status_code != 200:
        return 0
    else:
        data = json.loads(response.text)
        return data['data']['subscribers']