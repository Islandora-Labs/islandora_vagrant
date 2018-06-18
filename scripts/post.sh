#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat7/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat7/tomcat-users.xml
service tomcat7 restart

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

# Update Drupal and friends to something recent
drush --root=/var/www/drupal -v -y pm-update

# Allow anonymous & authenticated users to view repository objects
drush --root=/var/www/drupal role-add-perm "anonymous user" "view fedora repository objects"
drush --root=/var/www/drupal role-add-perm "authenticated user" "view fedora repository objects"
drush --root=/var/www/drupal cc all

# Config cantaloupe 
CANTALOUPE_RESPONSE=$(sleep 10 && curl -Is -o /dev/null -m 10 -w '%{http_code}\n' 'http://127.0.0.1:8080/cantaloupe/iiif/2' | tr -dc '[:alnum:]')
export CANTALOUPE_RUNNING="$CANTALOUPE_RESPONSE"

if [ "$CANTALOUPE_RUNNING" = "200" ] && [ "$CANTALOUPE_SETUP" = "TRUE" ] ; then

    drush --root=/var/www/drupal vset islandora_openseadragon_tilesource 'iiif'
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_url 'http://localhost:8000/iiif/2'
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_token_header 1
    drush --root=/var/www/drupal vset islandora_openseadragon_iiif_identifier '[islandora_openseadragon:pid]~[islandora_openseadragon:dsid]~[islandora_openseadragon:token]'

    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_identifier '[islandora_iareader:pid]~[islandora_iareader:dsid]~[islandora_iareader:token]'
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_url 'http://localhost:8000/iiif/2'
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_iiif_token_header 1
    drush --root=/var/www/drupal vset islandora_internet_archive_bookreader_pagesource 'iiif'
fi


# Lets brand this a bit

cat <<'EOT' >> /home/vagrant/.bashrc

echo "MMWNNNXXKKKK00000OOOOOOOOOkkkkkkxxxxxddddddooooooooooooooollc;',:cloodddddddxxxxxxxxxkkkkkkkkkkkOOOOOOOOOOOOOO00000000KKKKXXXXXNNXXXXKKK; . "
echo "MMNNNNXXXKKK0000OOOOOOOOOkkkkkxxxxdddddooooolllllllllllllllc:,. ..,:clooddddddxxxxxxxxxxxkkkkkkkkkkkOOOOOOOOOOOOO000000KKKXXXXXNNXXNNX0Oc.c:"
echo "MMNNNNXXXKKK0000OOOOOkkkkkkxxxxxxdddoooollllllcccccclcccclllc:;;'. .';:coooddddddddxxxxxxxxxxkkkxxxxxkkkOOOOOOOOOOOOOO000KKXXXXXNNNXkldxdc; "
echo "MNNNNXXXXKKK00OOOOOkkkkkkxxxddddddoollcc::c::::::ccccccccccccccc:;,.. .'::clooooodddddxxxxxxxddolc:cldxkkkOOOOOOOOOOOOOO00KKXXXXXX0oclxk'   "
echo "M0NNNXXXXKKK00OOOOkkkkkxxxxddddooollc;..   .,;;::::::::cccccccclccc:;'. ..,;:clooooodddddddolc:'.  'codxkkkkOkOOOOOOkOOOO00KKXXXXKOkxxxk.   "
echo "MMKXNXXXKKK000OOOkkkkkxxxxdddooollcc0xcdOOl..,;;;:::::::::cccccccllcc:;,.. ..,;:cclllllllc:,..  .';codxxxkkkkkkkkkkkkkkOOO000KKK0Odxxdxk.   "
echo "MMNXXXKKKKK00OOOOkkxkkkOkkxxxxdddo:l0dcl:;;'.':ccccclllllooodooodddddoool:;..  .';:ccc:;..  .';coodxkkkkkkxxxkkkkkkkkkkkOOO00K00KOdkOlok.   "
echo "MMNXXXXXKKK00OkkkkkOOOOOdcokkxdddlcOXkl;:xxo;:clllooooodddddddddxxxxxxxxxdoc:,.   .....  .':lodxkkkkkxkOOOkkdolc::::;:ldxkkOOOOkOkoxk:ck. ,;"
echo "KWNXNNNXXK000OkkOOOOOxlclxoldoccl;oXX0xO0oc,l:.',:::clllcclooolcloddoodxxdolc:,.       .,:lodxxxxxxkOkxxkOkk0dOkxxoloc'',:xkkOkkOxodk;;k. .."
echo "lXNXNNXXXK00OOO00Okxo:lxdc:cc:::okXNXO0W0:.;:    ':clooooddo:,'..',,:ldddooc;,..        ':lddxxddxxddxkxodkkx.d0kxOxoK0occxxxkxdkdlox,,k'   "
echo ";OXKXXXXXK0OOK0Okxlcldl;.,::,;ldO0KXKk0NXk:;.    '::clooo:...',;;;:;,',;:;'.   ..',;;,..  .:lloddddxxddxkxdxc,;O00OOkdKNkodddddoxolod.'x,   "
echo ".xKKXXXXXK0KX0kxlcodl;;. .,:x000000KXkl:coc;.    '::cllo,..',ccclcc:;..       .',;:cllcc;.. .';coodxxxxddxkxk..o00XN0xdxl:cllooldccoo .;;;. "
echo ".OKKXXKKK0KKOxlcdkc,':,. .lKXNNNXXXNNk,' .dd.    '::cllc..'.:c:lc;,..    ....',,,,,,,'','''.   .':cclc:;c:lK0;:0XXkX0xOd:'.,cllco:cll  ;.   "
echo ".kKKXKKKOlOOdcokx'',';,. ;KXNWWWWWWWXkd..  l,    '::clc;,,,,,,'..    ...,::::::::::::::;;,,....    .,clloloKXNNxkXXXOdolod:.;:::l,;ll  ,.   "
echo ".x0KKK00d,ol:llc. .'.,' ,0XNWWWWMWWMO;,,..  '    .'';:ccc:,'.     ..,;::lll::cllc:::;,;',,;;;:;..,;.'...;llcddc,xOkl:loxOOd..,,,c...   .    "
echo "'0O000OOl,lc'::'  .....;KXNWWWWWWWWWWKkkocc;;clcccclcl;;l:'''...,:cclllool;;coooooo::lo:c:oc;cllocoXOc..;dddoddooldkxdOdldx, ...;  'c       "
echo ",X000Okxc.c;.,;,.    .:0XNWMWWWWWWWWWWWNWWWWWWWNNNNXXK0kOKXKxcclooooooooooodoodddddddclc'cdc:cccclKNXXKK0NNXXXXNWWX0KXKK0oco....,  'c       "
echo "'K000Oxd: :;.';.     ;KXNWMMWWWWWWWWWWWWMWWWX0OkKXK0NWNX0xdllloddoooddddoodoodddddddddoodoooooooxXNNNNWWN00KXWNWWWWNXK0Okldx;  .'  .:       "
echo ".O00Okxo;.,,..,..'..;0XNWWWWWWWWMWNKKKNWWWWMl    .''lollllo;';lllcccc:::::llooolllodddoodoooooccKNNNNNWWNNWWWMNNMWWWNX0Odokxd'  .  .:       "
echo ".xO0Okdd; ,'..'..'.lXNWWMWWWWWWWWW0l. dXdWMM:    .',;cccllol. .:c:cccccc:::cccllllllloooooooocdKNNNNWWWWWWWWWWWXWWWWWWNKxdXold. .  .;       "
echo ".dOOOkdd; ,'..'. .lXNWWMWWWWWWMWWWWKO,lkOWMN'    .,',;:;cccl;  ;cll:;::::ccccc::::;;;ldllol;;oXXXXNWWWWWXKWWWMMKKWWMWWNNNl0Nlo: .  .;       "
echo ".okOkkdo, ,'..'. cXNNWWWWWWWWWWWWWNXKcdNWWWNl     ...''''',,'..  .........',,,;:::::clc;ccc::dKKXNNNNX0o:0MWWWMNkKWNWMKKWOxWXoo..  .;       "
echo " ckOkkdo, ,'..'. ONNWWWWWWWWWWWWWWWWWWWWkKWWx                              ....''',,;:;'',,,,lKKKK0kdoc:OWWWWWMWX0XWWMXOXNd0WKdd.  .;       "
echo " ck0Oxdo; ,, ...cNNWWWWWWWWWWWWWWMKxMWWW0'dWx                                        .,.;oc. .lo:......;NWWWWWWMWMMMMMNKNWKdXW0ko  .;       "
echo ".lkOOxdo, ', ..dNNWWWWWWWWWMWWWWWM0;WWNXXO.ok   .  ,. ,;,;;.   ';,,;. .:;,,';;,.';'',;c:ccc; .c;,,,,,,,OWNWWWWXWWWWWWWWXKNWKxNN0O; .:      ."
echo ".dOOOxol, '' .:NNWWWWWWWWWWWWWWWWMX'0MWWO;l.o.     ,  .'..c.   ;.          ..        :lccccc:c;.o. .;,lNNNWWWN0NMWWWWWWNXXWMKOWNKk..:       "
echo ".oO0Oxoo; ', .KWWWWWWWWWWWWMWWNWWWWKWWWWNk,;'.            .          ... .'.        ,oc::cc:cl' .   ..OWXNWWWW0WMWWWWWWWWWWMWKXWNK:.;       "
echo "'O00Okdol .'.OWWWWWWWWWWWWWMWWMMWWWWWWWWWWKc.                                        ..,;::ccl.      cNXKNWWWWKNMWWWWWWWWMWWMWKWWNk',       "
echo "cXK00Oxdo' .xWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXo..                      .. ...          .....',;;.     'KNKKWWWWNXNMWWMWWWWWMWWMMX0WWXx,       "
echo "xNXKKOkkxo:OWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNWd  I S L A N D O R A    7 . x - 1 . 1 1 ....',;,;.     kNKKNWWWWWNXWMWMWWWWWWWWWMW0KWWK:       "
echo "XMXKXK00OOXNNWWWWWWWMWWWWWWWWWWWWWWWWWWWWWWWWN,  An elegant software                 .'''''. ..    :NXKXWWWWWWWXNMWWWWWWWWWWWMWNOXWXl..     "
echo "WMNXNNXXKXNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWNNo  for a more civilized age            ';;::c; ..   .OXKXNWWWWWWWNNMWWWWWWWWWWWWWWXkXXO,'.    "
echo "MMWNWNNNNNWWWWWWWWMWWMWMWWWWWWWWWWWWWWWWWWWWWWk.                                     ....... ..   lNXNNWWNNWWNNNNMWWWWWWWWWWWWMMW00NXx::'   "
echo "MMWWWWNNNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWN0l.                                                'XNXNWWWNNNNNNNNWWWWWWWWWWMWWWWMNkXX0olll:,"
echo "NNWNNNNNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWXkc;.'.'''....            ...........''',,,,,'''''.'kWNNNWWNNNNNWNXNWWWWWWWWWWWWNWWWWKkNKkoooo:"
echo ":lOXXNNWWWWWWWWWWWWWWWWWWWWMWWWWWWWWWWWWWWWWWNd.;.;;:;;,'..            ......''',;;;::c::::::::,cXWNNNWWNNWNNWXNWWWWWWWWWWWWWWWWWMNkOXOxdddc"
echo "'l00XNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWMWWWo..'::;;,..              .....'''';::::::::::::::kWWNWWWWWNNNWWNWWWWWWWWWWWWWWWWMWWWXkK0Oxxxc"
echo "cNKKNWWWWWWWWWWWWWWWWWWWWWWWWWMWWWWWWWWWWWWWWWWNc  .,''..               ..   ....,:::::;::;::::cXMWWWWWWNNNWWWWWWWWWWWWWWWWWWWNWWWWWKkKOkxxc"
echo "KMWWWWWWWWWWWWWMMWWWMWWWWWWWWWWWWMWWWWWWWWWWWWWNK:,.  ..                ...     ..;;,;;,;;;;;;;lNWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWMWWWWKkxxdo;"
echo "WMWWWWWWWWWWWWWMMWMWWWWWMWWMWWWWWWWWWWWWWWWMWWWWNWNN0o..               ....     ..,,,,,,;;,;;;.oWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW0xdlc'"
echo "NMMWWWWWWWWWWWWMWWWWWWWWWWWWWWWWWWWWWWWMMMMMWWNNOdoc;,:'.....     . ........  ....,,;;,,,,;;;;o0XWWNWWWWWWWWWWWWWWWWWWWWWWMWWWWWWWWWWWNOd'.."
echo "0XWWWWWWWWWWWWWWWMWWWWWWWWWWWWMWWWWWWNNNNXXXKKK0x. .:ll:,''............',,,...',,,;;::;;;;:;;:coOXNWNNWNNNWWWWWWWWMMWMWWWMMWWWWWWWWWWWWKk. ."
echo "KNXKXNNWWWWWWWMMMWWWWWWWWWNNNXXXXKKK0000000000K0x  'lllc::::;,,,',,,,;:::::,,;cllccccccc:cccclox0XXXXNNXKKXXXNNNNWWWWWWWWWWWWWWWWWWWWWNKk. ."
echo "WWWWWWWMMMMMMMMMMWWWWWWWWWWWWWWWWWWWWWNNNXNNX0:.  ..'''.................'.......''.......',,,';0XWWWWWWWWWWWWWWWWWWWWWWWWWMMMWWWWWNK0Oo..   "
echo "WWWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNWWNk.   '.....................'.................'',,;0WMMMWWWWMMMMMMMMMMMMMMMMMMMMMMMMWWXkkc,     "
echo "-----------------------------------------"
echo " Welcome to the Islandora 7.x-1.11 Release VM "
echo " Islandora is at http://localhost:8000."                     
echo " User: admin"
echo " Pass: islandora"
echo " To exit use Ctrl+D or take The Falcon, Docked at Bay 327"
echo " More information is available at https://github.com/Islandora-Labs/islandora_vagrant/"
echo " "
echo " May The Islandora Community be with you!"
echo "-----------------------------------------"
EOT
