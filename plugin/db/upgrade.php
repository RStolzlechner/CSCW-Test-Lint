<?php

defined('MOODLE_INTERNAL') || die();

function xmldb_template_upgrade($oldversion = 0) {
    global $CFG, $DB;
    $dbman = $DB->get_manager();
    return true;
}
