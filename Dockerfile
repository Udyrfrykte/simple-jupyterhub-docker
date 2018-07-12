FROM jupyterhub/jupyterhub:0.8.1

RUN pip install oauthenticator jupyterhub-simplespawner jupyter

ADD conda_bootstrap.sh /usr/local/bin/
