<?php

defined('MOODLE_INTERNAL') || die();

$functions = array(
    'mod_template_getInfo' => array(
        'classname'   => 'mod_template_external',
        'methodname'  => 'getInfo',
        'classpath'   => 'mod/template/db/external.php',
        'description' => 'Get all users to display.',
        'type'        => 'read',
        'ajax'        => true,
        'loginrequired' => true
    )
);
