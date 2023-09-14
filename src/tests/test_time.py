import json


def test_get_current_time(client):
    response = client.get('/')
    data = json.loads(response.data)
    assert response.status_code == 200
    assert 'current_time' in data
    assert isinstance(data['current_time'], str)
