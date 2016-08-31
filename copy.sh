
cp -Rvu saltstack/salt/* /srv/salt


cp -Rvu saltstack/pillar/* /srv/pillar


cp -vu cloud.profiles.d/* /etc/salt/cloud.profiles.d/
cp -vu cloud.providers.d/* /etc/salt/cloud.providers.d/


#Copy reactor code
#cp -Rvu reactor/ /srv/


#config should not be here, this is for vagrant setup
