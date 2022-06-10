import app


def test_index():
    app.app.testing = True
    client = app.app.test_client()

    r = client.get("/")
    assert r.status_code == 200
    assert "Hello World" in r.data.decode("utf-8")
