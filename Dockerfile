FROM nvcr.io/nvidia/pytorch:22.03-py3

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list
RUN sed -i "s@http://\(deb\|security\).debian.org@https://mirrors.aliyun.com@g" /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update -y

RUN apt-get install -y --no-install-recommends gcc g++ make  python3 python3-dev python3-pip python3-venv python3-wheel espeak espeak-ng libsndfile1-dev && rm -rf /var/lib/apt/lists/*

RUN pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple llvmlite --ignore-installed

WORKDIR /root
COPY requirements.txt /root
#COPY requirements.dev.txt /root
#COPY requirements.notebooks.txt /root

RUN pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple -r requirements.txt

COPY . /root
RUN make install
RUN pip install -i https://mirrors.ustc.edu.cn/pypi/web/simple .

ENTRYPOINT ["tts"]
CMD ["--help"]
