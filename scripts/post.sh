#!/bin/bash

# Setup a user for Tomcat Manager
sed -i '$i<role rolename="admin-gui"/>' /etc/tomcat7/tomcat-users.xml
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui,admin-gui"/>' /etc/tomcat7/tomcat-users.xml
service tomcat7 restart

# Set correct permissions on sites/default/files
chmod -R 775 /var/www/drupal/sites/default/files

# Allow anonymous & authenticated users to view repository objects
drush --root=/var/www/drupal role-add-perm "anonymous user" "view fedora repository objects"
drush --root=/var/www/drupal role-add-perm "authenticated user" "view fedora repository objects"
drush --root=/var/www/drupal cc all

# Lets brand this a bit

cat <<'EOT' >> /home/vagrant/.bashrc
echo '                                                                                '
echo '                                                                          ..kl` '
echo '                                                                         .KKWMW '
echo '                                                                  ..,:loxKWWWNl '
echo '                                                           .`;lldxkNWMMMMMMNd.  '
echo '                                                      .`::l`:0dxKWWMWXOdc,.     '
echo '                                                  ..;;:,c0KOKWKko;`.            '
echo '                                               ..:.` ,NXNWOl`                   '
echo '                                            ..,..,OxONXd,                       '
echo '                                         .`c`oo`lONKo.     .;;;;;;;;;;;.        '
echo '                                       ..;`  .:0Nd`        cMMMMMMMMMMM;        '
echo '                                      .,,l:.lkOl.          .:::::::::::.        '
echo '                                    ,:,  .:d0c               ,l`  .,;.          '
echo '                                  ;dolo.;o0o               .XMMo dMMMM0         '
echo '                                .c:;  ,dxO`                dMN;.:MMK;KMl        '
echo '                               :dkc` .lok                  xM0..NMM,,XMl        '
echo '                      .;,..,,lx:,.;:,;ld                   .NMMMMMd.MMX.        '
echo ';`.```...        ...;d;...,:kxOl.,.;`lx                      cxkd,  :`          '
echo 'Kdkxxc`..;lKOocxNWXkc.... ..:kokkcdl`x.                    .;;;;;;;;;;;.        '
echo '    ..;:,,;okd0Ol.. .`.. . .l:,..`l`:c                     cMMMMMMMMMMM;        '
echo '           .c:.  .lO0od:,...`lc;.`l:O                      cMMkcccccccc.        '
echo '     .```,;od`,oXWMMMMXkc;::l:.col;lc              .x:     cMM:                 '
echo '   lkd;`.....,,XX0WWKdo:`c`:`. . .cx        .K0xc. ,Mx     cMM:                 '
echo '   KO:        KKoOXd;;`....,.    .:c         ,:lkNNOMx     ,xc.                 '
echo '  .;,.       lKoxXk;;,`...,..    .o               .dXo     cMMNOo;.             '
echo '            .W0cKKo;```. .:     `o,          ll.           .lKMMMMMW0dc.        '
echo '            :M00Xd,;,,..`.. .   .d           00,             cMM.`l0MMM;        '
echo '            oMNWWXk:::;`.;c .  .o            d`  .l.        .dMM0XMMMMX`        '
echo '            lMMWXWWXllx:l,`.  .,`            kWN0MX.       cMMMMWKxc`           '
echo '.dd,,...`:l,o00kKXNNN0Oxodd,...c             :OMMNl        ;Oo;.                '
echo ',`cx:``;;cldc,.. ,,ldk0WWNN0o;x.            .Nx,.lK,       .lllllllllll.        '
echo ' ;;,,`````,;lOdl,`.    ..cdokkl                ok          cMMMMMMMMMMM;        '
echo '              O0l:`c;....,:.lO                 0M.          ....cKMMMKc         '
echo '           .lXMMMXOo,`c;,l.,.;                  ..`.         `dNMMKl.           '
echo '       .,xl`..c0Ml,kWkl,..:.l                     KN`      `XMMMMOooooo.        '
echo 'o`..`````,dOd:;;lcc;o0OOK0x:;               .WWWWWWMMk     cMMMMMMMMMMM;        '
echo '``o`::c:,.         ,,`dxkoll.                .........      ...........         '
echo 'c;`.                c`.,;:;l                 ;;.           ,kkkkkkkkkkk.        '
echo '                     d.`oxcc                .NN;           cMMMMMMMMMMM;        '
echo '                     :  .,.`                      .        cMM:.....lMM;        '
echo '                     .c`:lo.                     .KN.      ;MMk.   .0MM,        '
echo '                      o;:cl                 .NNNNNWMMx      OMMMMMMMMMk         '
echo '                      :  .:                  ,,,,,,,,.       `ok000ko.          '
echo '                      :,:oc                   .,:::,          .:clc;.           '
echo '                      ;. .`                  0MXKKKNW:      :NMMMMMMMX,         '
echo '                      .l:cc                 `Mx.   .NO     :MMKl;,;lXMM`        '
echo '                       ;.;;                  oNMMMMW0.     xMM.     `MMo        '
echo '                       lccc                     ...        cMM0:,`,:KMM,        '
echo '                       . .;                                 lWMMMMMMMN:         '
echo '                       ;lll                  ........         ,coooc`           '
echo '                       . ..                 .MMMMMMMMx     .ccccccccccc.        '
echo '                       .lo`                  ..`KM`,Mx     cMMMMMMMMMMM;        '
echo '                       ..,                   l0MWMxxMd     .;;;;KMk;:MM;        '
echo '                       . .                  .WOc.l00x.       .l0MMx .MM;        '
echo '                       lx.                    .codl;       ,NMMM0MMNWMM.        '
echo '                       .`                    OMN00KMW,     cMKo. ,OXXO;         '
echo '                      `.                    `MX    ;MO     :x,.                 '
echo '                     .X,                     NMO. .KMl     cMMMNOo;.            '
echo '                     `.                       :d   o`       ,OMMWMMMW0d.        '
echo '                    ,.                           .d:         cMM..l0MMM;        '
echo '                  .d.                        ;;;;;KMx.      ,kMMNMMMMNO.        '
echo '                 `.                         .XXXXXXXXk     cMMMMKxc`            '
echo '              .``                                          ,d:.                 '
echo '              .                                                                 '
EOT