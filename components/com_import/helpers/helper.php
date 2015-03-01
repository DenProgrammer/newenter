<?php

class ImportHelper {

    function getCategoryList($id = 0, $lvl = 0) {
        $dbo  = JFactory::getDBO();
        $sql  = 'SELECT `c`.* 
					FROM `jos_vm_category` AS `c`
					INNER JOIN `jos_vm_category_xref` AS `cx` ON `cx`.`category_child_id`=`c`.`category_id`
					WHERE `cx`.`category_parent_id`=\'' . $id . '\' AND `c`.`category_publish`=\'Y\'
					ORDER BY `list_order`';
        $dbo->setQuery($sql);
        $rows = $dbo->LoadObjectList();
        foreach ($rows as $row) {
            $mass[$row->category_id]->category_id   = $row->category_id;
            $mass[$row->category_id]->category_name = $row->category_name;
            $mass[$row->category_id]->level         = $id;
            $mass[$row->category_id]->lvl           = $lvl;

            $temp = null;
            $temp = getCategoryList($row->category_id, ($lvl + 1));

            if ($temp)
                foreach ($temp as $item) {
                    $mass[$item->category_id]->category_id   = $item->category_id;
                    $mass[$item->category_id]->category_name = $item->category_name;
                    $mass[$item->category_id]->level         = $item->level;
                    $mass[$item->category_id]->lvl           = $item->lvl;
                }
        }

        return $mass;
    }

}
