; Run this from within the sites/default or sites/all directory, whichever you prefer:
; drush make --yes --no-core --contrib-destination=. islandora.drush.make

; Core version
core = 7.x

; Should always be 2.
api = 2

; Defaults that apply to all islandora modules.
defaults[projects][type] = "module"
defaults[projects][download][type] = "git"
defaults[projects][download][branch]  = "7.x"
defaults[projects][download][overwrite] = TRUE

;Islandora Modules
projects[islandora][download][url] = "http://github.com/Islandora/islandora.git"
projects[islandora_bagit][download][url] = "http://github.com/Islandora/islandora_bagit.git"
projects[islandora_batch][download][url] = "http://github.com/Islandora/islandora_batch.git"
projects[islandora_book_batch][download][url] = "http://github.com/Islandora/islandora_book_batch.git"
projects[islandora_bookmark][download][url] = "http://github.com/Islandora/islandora_bookmark.git"
projects[islandora_checksum][download][url] = "http://github.com/Islandora/islandora_checksum.git"
projects[islandora_checksum_checker][download][url] = "http://github.com/Islandora/islandora_checksum_checker.git"
projects[islandora_fits][download][url] = "http://github.com/Islandora/islandora_fits.git"
projects[islandora_image_annotation][download][url] = "http://github.com/Islandora/islandora_image_annotation.git"
projects[islandora_importer][download][url] = "http://github.com/Islandora/islandora_importer.git"
projects[islandora_internet_archive_bookreader][download][url] = "http://github.com/Islandora/islandora_internet_archive_bookreader.git"
projects[islandora_jwplayer][download][url] = "http://github.com/Islandora/islandora_jwplayer.git"
projects[islandora_marcxml][download][url] = "http://github.com/Islandora/islandora_marcxml.git"
projects[islandora_oai][download][url] = "http://github.com/Islandora/islandora_oai.git"
projects[islandora_ocr][download][url] = "http://github.com/Islandora/islandora_ocr.git"
projects[islandora_openseadragon][download][url] = "http://github.com/Islandora/islandora_openseadragon.git"
projects[islandora_paged_content][download][url] = "http://github.com/Islandora/islandora_paged_content.git"
projects[islandora_pathauto][download][url] = "http://github.com/Islandora/islandora_pathauto.git"
projects[islandora_pdfjs][download][url] = "http://github.com/Islandora/islandora_pdfjs.git"
projects[islandora_premis][download][url] = "http://github.com/Islandora/islandora_premis.git"
projects[islandora_scholar][download][url] = "http://github.com/Islandora/islandora_scholar.git"
projects[islandora_simple_workflow][download][url] = "http://github.com/Islandora/islandora_simple_workflow.git"
projects[islandora_solr_facet_pages][download][url] = "http://github.com/Islandora/islandora_solr_facet_pages.git"
projects[islandora_solr_metadata][download][url] = "http://github.com/Islandora/islandora_solr_metadata.git"
projects[islandora_solr_search][download][url] = "http://github.com/Islandora/islandora_solr_search.git"
projects[islandora_solr_views][download][url] = "http://github.com/Islandora/islandora_solr_views.git"
projects[islandora_solution_pack_audio][download][url] = "http://github.com/Islandora/islandora_solution_pack_audio.git"
projects[islandora_solution_pack_book][download][url] = "http://github.com/Islandora/islandora_solution_pack_book.git"
projects[islandora_solution_pack_collection][download][url] = "http://github.com/Islandora/islandora_solution_pack_collection.git"
projects[islandora_solution_pack_compound][download][url] = "http://github.com/Islandora/islandora_solution_pack_compound.git"
projects[islandora_solution_pack_disk_image][download][url] = "http://github.com/Islandora/islandora_solution_pack_disk_image.git"
projects[islandora_solution_pack_entities][download][url] = "http://github.com/Islandora/islandora_solution_pack_entities.git"
projects[islandora_solution_pack_image][download][url] = "http://github.com/Islandora/islandora_solution_pack_image.git"
projects[islandora_solution_pack_large_image][download][url] = "http://github.com/Islandora/islandora_solution_pack_large_image.git"
projects[islandora_solution_pack_newspaper][download][url] = "http://github.com/Islandora/islandora_solution_pack_newspaper.git"
projects[islandora_solution_pack_pdf][download][url] = "http://github.com/Islandora/islandora_solution_pack_pdf.git"
projects[islandora_solution_pack_video][download][url] = "http://github.com/Islandora/islandora_solution_pack_video.git"
projects[islandora_solution_pack_web_archive][download][url] = "http://github.com/Islandora/islandora_solution_pack_web_archive.git"
projects[islandora_videojs][download][url] = "http://github.com/Islandora/islandora_videojs.git"
projects[islandora_xacml_editor][download][url] = "http://github.com/Islandora/islandora_xacml_editor.git"
projects[islandora_xml_forms][download][url] = "http://github.com/Islandora/islandora_xml_forms.git"
projects[islandora_xmlsitemap][download][url] = "http://github.com/Islandora/islandora_xmlsitemap.git"
projects[objective_forms][download][url] = "http://github.com/Islandora/objective_forms.git"
projects[php_lib][download][url] = "http://github.com/Islandora/php_lib.git"



; Libraries

defaults[libraries][download][overwrite] = TRUE

libraries[pdfjs][download][type] = "file"
libraries[pdfjs][download][url] = "https://github.com/mozilla/pdf.js/releases/download/v1.0.907/pdfjs-1.0.907-dist.zip"
libraries[pdfjs][directory_name] = "pdfjs"
libraries[pdfjs][type] = "library"

libraries[bookreader][download][type] = "file"
libraries[bookreader][download][url] = "https://github.com/Islandora/internet_archive_bookreader/archive/master.zip"
libraries[bookreader][directory_name] = "bookreader"
libraries[bookreader][type] = "library"

libraries[tuque][download][type] = "git"
libraries[tuque][download][branch] = "1.x"
libraries[tuque][download][url] = "http://github.com/Islandora/tuque.git"

libraries[openseadragon][download][type] = "file"
libraries[openseadragon][download][url] = "http://openseadragon.github.io/releases/openseadragon-bin-0.9.129.zip"
libraries[openseadragon][directory_name] = "openseadragon"
libraries[openseadragon][type] = "library"

libraries[BagItPHP][download][type] = "git"
libraries[BagItPHP][download][url] = "git://github.com/scholarslab/BagItPHP.git"
libraries[BagItPHP][directory_name] = "BagItPHP"
libraries[BagItPHP][type] = "library"

libraries[video-js][download][type] = "file"
libraries[video-js][download][url] = "http://www.videojs.com/downloads/video-js-4.0.0.zip"
libraries[video-js][directory_name] = "video-js"
libraries[video-js][type] = "library"
