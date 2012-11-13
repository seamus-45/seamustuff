Instructions to use this repository:
====================================

1.  emerge layman
2.  add this line to /etc/layman/layman.cfg:
    overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
                file:///var/lib/layman/tm-calculate.xml
3.  run command:
    sudo cat >/var/lib/layman/tm-calculate.xml<<EOF
4.  paste text:
    <?xml version="1.0" ?>
    <repositories version="1.0">
      <repo priority="50" quality="experimental" status="unofficial">
        <name>tm-calculate</name>
        <description>Custom Calculate Linux Overlay for TaxiMaxim</description>
        <homepage>https://github.com/tm-calculate</homepage>
        <owner>
          <email>fedotov_sv@taximaxim.ru</email>
        </owner>
        <source type="git">git://github.com/tm-calculate/tm-calculate.git</source>
      </repo>
    </repositories>
5.  and finish with EOF
6.  sync & add our repository: layman -S && layman -s tm-calculate
7.  Enjoy! (:

Screenshots:
![xfce](https://raw.github.com/tm-calculate/tm-calculate/master/images/xfce.png)

