<?php
    
    defined('MOODLE_INTERNAL') || die();
    
    $settings->add(
        new admin_setting_configtext(
            'template/someconfig', 
            get_string('confentry', 'template'),
            get_string('confdescription', 'template'), 
            get_string('confvalue', 'template'), 
            PARAM_RAW, 
            40
        )
    );