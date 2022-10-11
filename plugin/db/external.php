<?php

defined('MOODLE_INTERNAL') || die();
require_once($CFG->libdir . "/externallib.php");

class mod_template_external extends external_api {

    public static function getInfo_parameters(){
        return new external_function_parameters(
            array(
                'cmid' => new external_value(PARAM_INT, 'id of cwr', VALUE_REQUIRED)
            )
        ); 
    }

    public static function getInfo($cmid){        
        try{
            global $DB, $USER, $PAGE;                  
            $cm = get_coursemodule_from_id('template', $cmid, 0, false, MUST_EXIST);           
            $data = $DB->get_record('template', array('id' => $cm->instance), '*', MUST_EXIST);
            $course = $data->course;
            $permission = new mod_template\permission\course($USER->id, $course);
            if(!$permission->isAnyKindOfModerator()){                
                throw new Exception('No permission');
            }   
            try{               
                $PAGE->set_context(context_system::instance());    
                $data->intro = format_module_intro('template', $data, $cm->id);     
            } catch(Exception $e){}    
            return array(
                'success' => true,
                'data' => json_encode($data)
            );
        } catch(Exception $ex){
            return array(
                'success' => false,
                'data' => json_encode($ex->getMessage())
            ); 
        }        
    }

    public static function getInfo_returns(){
        return new external_single_structure(
            array(
                'success' => new external_value(PARAM_BOOL, 'Success Variable'),
                'data' => new external_value(PARAM_RAW, 'The output')
            )
        );
    }

    public static function getInfo_is_allowed_from_ajax(){
        return true;
    }   
}
