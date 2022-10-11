<?php

function template_add_instance($data) {
    global $DB;

    $data->timecreated = time();
    $data->timemodified = time();

    $id = $DB->insert_record('template', $data);
    return $id;
}


function template_update_instance($data) {
    
    global $DB;

    $data->timemodified = time();
    $data->id = $data->instance;

    return $DB->update_record('template', $data);
}

function template_delete_instance($id) {

    global $DB;

    if(!$DB->get_record('template', array('id' => $id))) {
        return false;
    }

    $DB->delete_records('template', ['id' => $id]);    
    return true;
}


function template_supports($feature) {
    switch ($feature) {
        case FEATURE_GROUPS:
            return false;
        case FEATURE_GROUPINGS:
            return false;
        case FEATURE_MOD_INTRO:
            return true;
        case FEATURE_BACKUP_MOODLE2:
            return true;
        case FEATURE_SHOW_DESCRIPTION:
            return true;
        default:
            return null;
    }
}