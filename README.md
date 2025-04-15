# 🐍 Oracle + Python 3 Docker Image

This project provides a Docker image based on **Oracle Linux 8**, with:

- Python 3 installed and aliased as `python`
- Oracle Instant Client 11.2 installed locally from zip
- `cx_Oracle` Python library ready to connect to Oracle databases

---

## 📦 Requirements

- Docker installed
- `instantclient-basic-linux.x64-11.2.0.4.0.zip` in the same folder as the Dockerfile

---

## 🚀 Build the Image

```bash
docker build -t python-oracle .
```

---

## ▶️ Run the Container

You can run an interactive shell:

```bash
docker run -it --rm python-oracle
```

Or run a Python script (assuming `script.py` is in the same directory):

```bash
docker run --rm -v $(pwd):/app -w /app python-oracle python script.py
```

---

## 🛠 Environment Variables

Inside the container:

- `ORACLE_HOME`: `/opt/oracle/instantclient_11_2`
- `LD_LIBRARY_PATH`: set to Oracle library path
- `python`: points to Python 3 interpreter

---

## 🧪 Test the Connection (Example)

Create a `test_connection.py` file:

```python
import cx_Oracle

dsn = cx_Oracle.makedsn("your_host", 1521, service_name="your_service")
conn = cx_Oracle.connect(user="your_user", password="your_pass", dsn=dsn)

cursor = conn.cursor()
cursor.execute("SELECT * FROM dual")
for row in cursor:
    print(row)
cursor.close()
conn.close()
```

Then run:

```bash
docker run --rm -v $(pwd):/app -w /app python-oracle python test_connection.py
```

---

## 📁 Project Structure

```
.
├── Dockerfile
├── instantclient-basic-linux.x64-11.2.0.4.0.zip
├── script.py          # Optional Python script
└── README.md
```

---

## 🧾 Notes

- The Oracle client zip is not downloaded during the build, it must be placed manually due to Oracle licensing.
- You can switch to another Oracle Client version if needed, just update paths and symlinks accordingly.

---

## 📜 License

This project is licensed for educational and internal usage. Oracle Instant Client is subject to [Oracle's license agreement](https://www.oracle.com/database/technologies/instant-client/downloads.html).

⚠️ Due to Oracle licensing restrictions, the Instant Client zip file must be downloaded manually from:
https://www.oracle.com/database/technologies/instant-client/downloads.html
and placed in the project directory before building the Docker image.
