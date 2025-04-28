 FROM python
 RUN mkdir /MARSQA_demo
 RUN chmod 777 /MARSQA_demo
 COPY . /MARSQA_demo
 WORKDIR /MARSQA_demo
 RUN pip install -r requirements.txt
 CMD ["python", "app.py"]
