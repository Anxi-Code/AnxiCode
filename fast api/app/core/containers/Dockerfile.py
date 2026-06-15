# python docker file

# python compiler
FROM python:3.11-slim

WORKDIR /sandbox

CMD ["python3", "main.py"]