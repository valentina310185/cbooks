<?php
require_once "security.php";
require_once "systemqueries.php";
require_once "model.php";
require_once "requestmanager.php";

/*******************************************************
Reference to work with word document
https://github.com/evidenceprime/html-docx-js

Reference to work with pdf document
https://parall.ax/products/jspdf
Note: When making a jspdf document remember to send this header to the client
header('Content-Type: application/javascript');
You may also use the function RequestManager::ScriptResponseHeader() to deal with this
So jquery understand that the code is a script

*******************************************************/

/**
 * This clas is used for the forms buildment and management
 */
class Form
{
    /**
     * Gets and build the search form
     */
	public static function GetSearchForm($form_name_id)
	{
		$form = current(Model::ArrayToObject(SystemQueries::GetFormDefinition($form_name_id)));
		eval("?>" .  $form->form_above_code);
		?>
		<form id="<?=$form->form_id?>_search" name="<?=$form->form_name?>_search" action="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=BtnSearchRecords" method="<?=$form->form_method?>" class="<?=$form->form_class?> search" enctype="<?=$form->form_enctype?>" autocomplete="<?=$form->form_autocomplete?>" target="<?=$form->form_target?>" <?=$form->form_attributes?>>
		<?php
		eval("?>" .  $form->form_title_code);
		if(strpos(strtolower($form->form_options), "all") !== false || strpos(strtolower($form->form_options), "add") !== false)
		{
			?>
				<div class="pull-right">
					<a href="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=BtnInsertForm" class="btn btn-default add"><i class="fa fa-plus"></i> New</a>
				</div>
				<div class="clearfix"></div>
			<?php
		}
		
		$form_inputs = Model::ArrayToObject(SystemQueries::GetSearchInputs($form_name_id));
		foreach ($form_inputs as $input) 
		{
			eval("?>" .  $input->input_above_input_code);
			?>
			<div class="<?=$input->input_grid_layout_class?> form-group has-feedback">
				<label for="<?=$input->input_name?>" class='control-label'><?=$input->input_label_text?></label>
			<?php
			if($input->input_type == "select")
			{
				$options = SystemQueries::GetSelectOptions($input->select_query_name);
			?>
				<div><select id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?>">
				<?php
				foreach ($options as $option) 
				{
				?>
					<option value="<?=$option[$input->select_column_name_for_value]?>">
					<?=$option[$input->select_column_name_for_description]?></option>
				<?php
				}
				?>
				</select><span class="help-block"><?=$input->input_help_text?></span></div></div>
				<?php
			}
			else
			{
			?>
				<div><input type="<?=$input->input_type?>" id="<?=$input->input_id?>" name="<?=$input->input_name?>" class='form-control' maxlength="<?=$input->input_maxlength?>" placeholder="<?=$input->input_placeholder?>" <?=str_replace("disabled", "", str_replace("readonly", "", $input->input_attributes))?>><span class="help-block"><?=$input->input_help_text?></span></div></div>
			<?php
			}			
			eval("?>" .  $input->input_below_input_code);
		}
		?>
		<div class="clearfix"></div>
		<hr><div class="text-center"><button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-search"></i> Search</button></div>
		</form>
		<hr><div id='table-content' name='table-content'></div>
		<?php
		eval("?>" .  $form->form_below_code);
	}
	
    /**
     * Gets a view stored on the database
     */
	public static function GetView($view_name)
	{
	    $view = SystemQueries::GetView($view_name);
        if(count($view) == 0)
        {
            RequestManager::RequestError("The view " . $view_name . " doesn't exist!");
        }
        else
        {
            eval("?>" . current(Model::ArrayToObject($view))->view_code);
        }		
	}
	
    /**
     * Gets and build a blank form for new records
     */
	public static function GetInsertForm($form_name_id)
	{
		$form = current(Model::ArrayToObject(SystemQueries::GetFormDefinition($form_name_id)));
		eval("?>" .  $form->form_above_code);			
		self::GetFormOptions($form);
		?>
		<form id="<?=$form->form_id?>" name="<?=$form->form_name?>" action="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=BtnInsertRecord" method="<?=$form->form_method?>" class="<?=$form->form_class?>" enctype="<?=$form->form_enctype?>" autocomplete="<?=$form->form_autocomplete?>" target="<?=$form->form_target?>" <?=$form->form_attributes?>>
		<?php
		eval("?>" .  $form->form_title_code);
		self::GetBlankInputsForm($form_name_id);
		?>
		<div class="clearfix"></div>
		<hr><div class="text-center"><button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-save"></i> Save</button></div>
		</form>
		<?php
		eval("?>" . $form->form_below_code);
		?>
		<script>jQuery('.modal-dialog').css('width', '95%')</script>
		<?php
	}
    
    /**
     * Gets and build all inputs with no data loaded
     */
    private static function GetBlankInputsForm($form_name_id)
    {
        $inputs = Model::ArrayToObject(SystemQueries::GetFormInputsDefinition($form_name_id));
        foreach ($inputs as $input) 
        {
            eval("?>" . $input->input_above_input_code);
            ?>
            <div class="<?=$input->input_grid_layout_class?> form-group has-feedback">
            <label for="<?=$input->input_id?>" class='control-label'><?=$input->input_label_text?></label>
            <?php
            if($input->input_type == "select")
            {
                $options = SystemQueries::GetSelectOptions($input->select_query_name);
                ?>
                <div><select id="<?=$input->input_id?>" name="<?=$input->input_name?>" <?=$input->input_attributes?> class="<?=$input->input_class?>">
                <?php
                foreach ($options as $option) 
                {
                    ?>
                    <option value="<?=$option[$input->select_column_name_for_value]?>"><?=$option[$input->select_column_name_for_description]?></option>
                    <?php
                }
                ?>
                </select></div></div>
                <?php
            }
            else if($input->input_type == "file")
            {
            ?>
                <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" <?=$input->input_attributes?>><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
            }
            else if($input->input_type == "textarea")
            {
            ?>
                <div><textarea id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>></textarea><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
            }
            else
            {
            ?>
                <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
            }                       
            eval("?>" . $input->input_below_input_code);
        }
    }
    /**
     * Builds the form options buttons
     */
    private static function GetFormOptions($form)
    {
        //Verificamos si hay alguna opcion al menos y las creamos
        if(trim($form->form_options) != "")
        {
            ?> 
            <hr> 
            <?php
            if(strpos(strtolower($form->form_options), "all") !== false)
            {
                ?>
                <div class="btn-group">                 
                    <a class="btn btn-default print-form" title="Print"><i class="fa fa-print"> Print</i></a>                 
                    <a class="btn btn-default export-form doc" title="Word"><i class="fa fa-file-word-o"> Word</i></a>                   
                    <a class="btn btn-default export-form png" title="Image"><i class="fa fa-picture-o"> Image</i></a>                    
                </div>
                <?php
            }
            else
            {
                ?>
                <div class="btn-group">
                <?php
                if(strpos(strtolower($form->form_options), "print") !== false)
                {
                    ?>
                    <a class="btn btn-default print-form" title="Print"><i class="fa fa-print"> Print</i></a>
                    <?php
                }
                if(strpos(strtolower($form->form_options), "word") !== false)
                {
                    ?>
                    <a class="btn btn-default export-form doc" title="Word"><i class="fa fa-file-word-o"> Word</i></a>
                    <?php
                }
                if(strpos(strtolower($form->form_options), "image") !== false)
                {
                    ?>
                    <a class="btn btn-default export-form png" title="Image"><i class="fa fa-picture-o"> Image</i></a>
                    <?php
                }
                ?>
                </div>
                <?php
            }
            ?>
            <hr>
            <?php
        }
    }
	
    /**
     * Gets a build a form in insert mode, loading some info for a new records where in the case a record is needed to be inserted on a child table
     */
	public static function GetInsertChildForm($form_name_id, $query_name)
	{
		//Buscamos el record
		$record = SystemQueries::GetRecordToUpdate($query_name);
		if(count($record) == 0)
		{
		    RequestManager::RequestNoRecordFound();
		}
		$form = current(Model::ArrayToObject(SystemQueries::GetFormDefinition($form_name_id)));
		eval("?>" .  $form->form_above_code);
        self::GetFormOptions($form);			
		?>
		<form id="<?=$form->form_id?>" name="<?=$form->form_name?>" action="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=BtnInsertRecord" method="<?=$form->form_method?>" class="<?=$form->form_class?>" enctype="<?=$form->form_enctype?>" autocomplete="<?=$form->form_autocomplete?>" target="<?=$form->form_target?>" <?=$form->form_attributes?>>		
		<?php
		eval("?>" .  $form->form_title_code);
		
		//Buscamos los inputs
		$inputs = Model::ArrayToObject(SystemQueries::GetFormInputsDefinition($form_name_id));
		self::GetInputsLoaded($inputs, $record);
		?>
		<div class="clearfix"></div>
		<hr><div class="text-center"><button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-save"></i> Save</button></div>
		</form>
		<?php
		eval("?>" . $form->form_below_code);
		?>
		<script>jQuery('.modal-dialog').css('width', '95%')</script>
		<?php
	}

    private static function GetInputsLoaded($inputs, $record)
    {
        foreach ($inputs as $input) 
        {
            eval("?>" . $input->input_above_input_code);
            ?>
            <div class="<?=$input->input_grid_layout_class?> form-group has-feedback">
            <label for="<?=$input->input_id?>" class='control-label'><?=$input->input_label_text?></label>
            <?php
            if($input->input_type == "select")
            {
                $options = SystemQueries::GetSelectOptions($input->select_query_name);
                ?>
                <div><select id="<?=$input->input_id?>" name="<?=$input->input_name?>" <?=$input->input_attributes?> class="<?=$input->input_class?>">
                <?php
                foreach ($options as $option) 
                {
                    if(isset($record[0][$input->input_name]) && !empty($record[0][$input->input_name]) && ($record[0][$input->input_name]) == $option[$input->select_column_name_for_value])
                    {
                        ?>
                        <option selected value="<?=$option[$input->select_column_name_for_value]?>"><?=$option[$input->select_column_name_for_description]?></option>
                        <?php
                    }
                    else
                    {
                        ?>
                        <option value="<?=$option[$input->select_column_name_for_value]?>"><?=$option[$input->select_column_name_for_description]?></option>
                        <?php
                    }   
                }
                ?>
                </select><span class="help-block"><?=$input->input_help_text?></span></div></div>
                <?php
            }
            else if($input->input_type == "file")
            {
                if(isset($record[0][$input->input_name]) && !empty($record[0][$input->input_name]))
                {
            ?>
                    <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" <?=$input->input_attributes?>></div><a class='download btn btn-default' href='server.php?file_download_url=<?=$record[0][$input->input_name]?>'><i class="fa fa-download"></i> Download</a><input name="<?=$input->input_name?>" type="hidden" value="<?=Security::EncryptText($record[0][$input->input_name])?>"><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
                }
                else
                {
            ?>
                    <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" <?=$input->input_attributes?>><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php       
                }   
            }
            else if($input->input_type == "textarea")
            {
                if(isset($record[0][$input->input_name]) && !empty($record[0][$input->input_name]))
                {
            ?>
                    <div><textarea id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>><?=$record[0][$input->input_name]?></textarea><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
                }
                else
                {
            ?>
                    <div><textarea id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>></textarea><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php   
                }
            }
            else
            {
                if(isset($record[0][$input->input_name]) && !empty($record[0][$input->input_name]))
                {
            ?>
                    <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?= $input->input_attributes?> value="<?=$record[0][$input->input_name]?>"><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
                }
                else
                {
            ?>
                    <div><input id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>><span class="help-block"><?=$input->input_help_text?></span></div></div>
            <?php
                }
            }                       
            eval("?>" . $input->input_below_input_code);
        }
    }
	
     /**
     * Gets a build a form in update mode, loading a record withing the form.
     */
	public static function GetUpdateForm($form_name_id, $query_name)
	{
		//Buscamos el record
		$record = SystemQueries::GetRecordToUpdate($query_name);
		if(count($record) == 0)
		{
			header("HTTP/1.1 404 No Record Found");
			die();
		}
		$form = current(Model::ArrayToObject(SystemQueries::GetFormDefinition($form_name_id)));
		eval("?>" .  $form->form_above_code);
		?>
		<form id="<?=$form->form_id?>" name="<?=$form->form_name?>" action="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=BtnUpdateRecord" method="<?=$form->form_method?>" class="<?=$form->form_class?>" enctype="<?=$form->form_enctype?>" autocomplete="<?=$form->form_autocomplete?>" target="<?=$form->form_target?>" <?=$form->form_attributes?>>
		<?php
		eval("?>" .  $form->form_title_code);
		//Buscamos los inputs de la forma
		$inputs = Model::ArrayToObject(SystemQueries::GetFormInputsDefinition($form_name_id));
        self::GetInputsLoaded($inputs, $record);
		?>
		<div class="clearfix"></div>
		<div class="text-center"><button type="submit" class="btn btn-primary btn-lg"><i class="fa fa-save"></i> Save</button></div>
		</form>
		<?php
		eval("?>" . $form->form_below_code);
		?>
		<script>jQuery('.modal-dialog').css('width', '95%')</script>
		<?php
	}
	
    /**
     * Gets the query, executes it, loads a table definition that is stored on the database and builds the table
     */
	public static function SearchRecords($query_name, $table_view_name)
	{
		//Get the view rows
		$rows =  SystemQueries::GetSearchRows($query_name);
		if(count($rows) == 0)
		{
			RequestManager::RequestNoRecordFoundSearch();
		}
		//Get the view definitions
		$view_definition = current(Model::ArrayToObject(SystemQueries::GetTableViewDefinitions($table_view_name)));
		//Get the view columns
		$columns = Model::ArrayToObject(SystemQueries::GetViewColumns($table_view_name));
		//Gets and build the print options
		self::GetPrintExportOptions($view_definition);
		//Creamos la tabla
		?>
		<div class='table-responsive'><table class='table table-striped table-bordered table-hover'><thead><tr>
		<?php
		  self::GetUpdateDeleteOptions($view_definition);
		  self::GetViewColumns($columns);
		?>
		</tr></thead><tbody>
		<?php
            self::GetTableData($view_definition, $columns, $rows);
		?>
		</tbody></table></div>
		<?php	
	}

    private static function GetTableData($view_definition, $columns, $rows)
    {
        foreach ($rows as $row) 
        {
            ?>
            <tr>
            <?php
                self::GetViewRowsOptions($view_definition, $row);
                self::GetViewRowsData($columns, $row);              
            ?>
            </tr>
            <?php
        }
    }
	
    /**
     * Gets and build the table rows
     */
    private static function GetViewRowsData($columns, $row)
    {
        foreach ($columns as $column) 
        {
            $style = "style='";
            if($column->rows_text_align != "")
            {
                $style .= "text-align:" . $column->rows_text_align . ";";
            }
            if($column->rows_font_style != "")
            {
                $style .= "font-style:" . $column->rows_font_style . ";";
            }
            if($column->rows_font_weight != "")
            {
                $style .= "font-weight:" . $column->rows_font_weight . ";";
            }
            if($column->rows_background_color != "")
            {
                $style .= "background-color:" . $column->rows_background_color . ";";
            }
            if($column->rows_text_color != "")
            {
                $style .= "color:" . $column->rows_text_color . ";";
            }
            $style .= "'";
            ?>
            <td <?=$style?>><?php 
            if(is_file($row[$column->table_view_column_name]) || filter_var($row[$column->table_view_column_name], FILTER_VALIDATE_URL))
            {
            ?>
                <a class='download btn btn-default btn-block' href='server.php?file_download_url=<?=$row[$column->table_view_column_name]?>'><i class="fa fa-download"></i> Download</a>
            <?php
            }
            else echo $row[$column->table_view_column_name];?></td>
            <?php
        }
    }

    /**
     * Gets and build the table rows option(Update and Delete buttons)
     */
    private static function GetViewRowsOptions($view_definition, $row)
    {
        if(strpos(strtolower($view_definition->table_options), "all") !== false || strpos(strtolower($view_definition->table_options), "edit") !== false)
        {
            ?>
            <td class='edit'><a href="<?=$view_definition->table_action?>?class_name=<?=$view_definition->class_name?>&function_name=BtnUpdateForm" class="btn btn-primary edit" data-id='{"<?=$view_definition->table_column_key_name?>":"<?=$row[$view_definition->table_column_key_name]?>"}'><i class='fa fa-pencil'></i></a></td>
            <?php
        }
        if(strpos(strtolower($view_definition->table_options), "all") !== false || strpos(strtolower($view_definition->table_options), "delete") !== false)
        {
            ?>
            <td class='delete'><a href="<?=$view_definition->table_action?>?class_name=<?=$view_definition->class_name?>&function_name=BtnDeleteRecord" class="btn btn-danger delete" data-id='{"<?=$view_definition->table_column_key_name?>":"<?=$row[$view_definition->table_column_key_name]?>"}'><i class='fa fa-close'></i></a></td>
            <?php
        }
    }
    
    /**
     * Gets and build the table columns
     */
    private static function GetViewColumns($columns)
    {
        foreach ($columns as $column) 
        {
            $style = "style='";
            if($column->column_header_text_align != "")
            {
                $style .= "text-align:" . $column->column_header_text_align . ";";
            }
            if($column->column_header_font_style != "")
            {
                $style .= "font-style:" . $column->column_header_font_style . ";";
            }
            if($column->column_header_font_weight != "")
            {
                $style .= "font-weight:" . $column->column_header_font_weight . ";";
            }
            if($column->column_header_background_color != "")
            {
                $style .= "background-color:" . $column->column_header_background_color . ";";
            }
            if($column->column_header_text_color != "")
            {
                $style .= "color:" . $column->column_header_text_color . ";";
            }
            $style .= "'";
            ?>
            <th <?=$style?>><?=$column->table_view_column_header_label?></th>
            <?php
        }
    }
    
    /**
     * Gets and build the table header option(Update and Delete label)
     */
    private static function GetUpdateDeleteOptions($view_definition)
    {
        if(strpos(strtolower($view_definition->table_options), "all") !== false || strpos(strtolower($view_definition->table_options), "edit") !== false)
        {
            ?>
            <th class='edit'>Edit</th>
            <?php
        }
        if(strpos(strtolower($view_definition->table_options), "all") !== false || strpos(strtolower($view_definition->table_options), "delete") !== false)
        {
            ?>
            <th class='delete'>Delete</th>
            <?php
        }
    }
    
    /**
     * Gets and build de print or export option for the table view
     */
    private static function GetPrintExportOptions($view_definition)
    {
        //Verificamos si hay alguna opcion al menos y las creamos
        if(trim($view_definition->table_options) != "")
        {
            echo "<hr>";
            if(strpos(strtolower($view_definition->table_options), "all") !== false)
            {
                ?>
                    <div class="btn-group">
                      <a class="btn btn-default print-table" title="Print"><i class="fa fa-print"> Print</i></a>
                      <a class="btn btn-default export-table pdf" title="Pdf"><i class="fa fa-file-pdf-o"> Pdf</i></a>
                      <a class="btn btn-default export-table doc" title="Word"><i class="fa fa-file-word-o"> Word</i></a>
                      <a class="btn btn-default export-table excel" title="Excel"><i class="fa fa-file-excel-o"> Excel</i></a>
                      <a class="btn btn-default export-table csv" title="Csv"><i class="fa fa-file-text"> Csv</i></a>
                      <a class="btn btn-default export-table png" title="Image"><i class="fa fa-picture-o"> Image</i></a>
                    </div>
                <?php
            }
            else
            {
                ?>
                <div class="btn-group">
                <?php
                if(strpos(strtolower($view_definition->table_options), "print") !== false)
                {
                    ?>
                    <a class="btn btn-default print-table" title="Print"><i class="fa fa-print"> Print</i></a>
                    <?php
                }
                if(strpos(strtolower($view_definition->table_options), "pdf") !== false)
                {
                    ?>
                    <a class="btn btn-default export-table pdf" title="Pdf"><i class="fa fa-file-pdf-o"> Pdf</i></a>
                    <?php
                }
                if(strpos(strtolower($view_definition->table_options), "word") !== false)
                {
                    ?>
                    <a class="btn btn-default export-table doc" title="Word"><i class="fa fa-file-word-o"> Word</i></a>
                    <?php
                }
                if(strpos(strtolower($view_definition->table_options), "excel") !== false)
                {
                    ?>
                    <a class="btn btn-default export-table excel" title="Excel"><i class="fa fa-file-excel-o"> Excel</i></a>
                    <?php
                }
                if(strpos(strtolower($view_definition->table_options), "csv") !== false)
                {
                    ?>
                    <a class="btn btn-default export-table csv" title="Csv"><i class="fa fa-file-text"> Csv</i></a>
                    <?php
                }
                if(strpos(strtolower($view_definition->table_options), "image") !== false)
                {
                    ?>
                    <a class="btn btn-default export-table png" title="Image"><i class="fa fa-picture-o"> Image</i></a>
                    <?php
                }
                ?>
                </div>
                <?php
            }
            ?>
            <hr>
            <?php
        }
    }

    /**
     * Builds a editable table with all records loaded and auto saves changes using ajax on input blur event
     */
    public static function MaintenanceTable($form_name_id, $query_name)
    {
        //Gets the form definition    
        $form = current(Model::ArrayToObject(SystemQueries::GetFormDefinition($form_name_id)));
        ?>
        <form id="<?=$form->form_id?>" name="<?=$form->form_name?>" action="<?=$form->form_action?>?class_name=<?=$form->class_name?>&function_name=MaintenanceTableRecordUpdate" method="<?=$form->form_method?>" enctype="<?=$form->form_enctype?>" autocomplete="<?=$form->form_autocomplete?>" target="<?=$form->form_target?>" <?=$form->form_attributes?>>
        <h3>Table of Maintenance for <?=ucwords($form->form_name)?></h3>
        <?php
        //Get the form inputs
        $inputs = Model::ArrayToObject(SystemQueries::GetFormInputsDefinition($form_name_id));
        //Gets the query and the records
        $query = SystemQueries::GetQuery($query_name);
        $rows = Model::ArrayToObject(DBManager::ExecuteQuery($query[0]["query_text"]));
        ?>
        <div class='table-responsive'><table class='table table-striped table-bordered table-hover'><thead><tr>
        <?php
            self::GetMaintenanceTableColumnLabelText($inputs);
        ?>
        </tr></thead><tbody>
        <?php
            self::GetMaintenanceTableData($inputs, $rows, $form);
        ?>
        </tbody></table></div></form>
        <?php   
    }
    
    /**
     * Gets and build the maintenance table header label text
     */
    private static function GetMaintenanceTableColumnLabelText($inputs)
    {
        foreach ($inputs as $input) 
        {
            ?>
            <th><?=$input->input_label_text?></th>
            <?php
        }
    }
    
    /**
     * Gets and build the maintenance table looping through all rows
     */
    private static function GetMaintenanceTableData($inputs, $rows)
    {
        foreach ($rows as $row)
        {
        ?>
            <tr>
            <?php
                self::GetMaintenanceTableInputs($inputs, $row);
            ?>
            </tr>
            <?php
        }
    }
    
    /**
     * Gets and build the maintenance table inputs and data
     */
    private static function GetMaintenanceTableInputs($inputs, $row)
    {
        foreach ($inputs as $input)
        {
            ?>
            <td>
            <div class="form-group has-feedback">
            <?php 
            if($input->input_type == "select")
            {
                $options = SystemQueries::GetSelectOptions($input->select_query_name);
                ?>
                <div><select onchange="Input.ValidateInputAndTableSubmitRow(this)" id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?>" <?=$input->input_attributes?>>
                <?php
                foreach ($options as $option) 
                {
                    if(($row[$input->input_name]) == $option[$input->select_column_name_for_value])
                    {
                        ?>
                        <option selected value="<?=$option[$input->select_column_name_for_value]?>"><?=$option[$input->select_column_name_for_description]?></option>
                        <?php
                    }
                    else
                    {
                        ?>
                        <option value="<?=$option[$input->select_column_name_for_value]?>"><?=$option[$input->select_column_name_for_description]?></option>
                        <?php
                    }               
                }
                ?>
                </select></div></div>
                <?php
            }
            else if($input->input_type == "file")
            {
            ?>
                <div><input onchange="Input.ValidateInputAndTableSubmitRow(this)" id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" <?=$input->input_attributes?>></div><a class='download btn btn-default' href='server.php?file_download_url=<?=$row->{$input->input_name}?>'><i class="fa fa-download"></i> Download</a><input name="<?=$input->input_name?>" type="hidden" value="<?=Security::EncryptText($row->{$input->input_name})?>"></div></div>
            <?php
            }
            else if($input->input_type == "textarea")
            {
            ?>
                <div><textarea onchange="Input.ValidateInputAndTableSubmitRow(this)" id="<?=$input->input_id?>" name="<?=$input->input_name?>" class="<?=$input->input_class?> <?php if($input->input_is_nullable == "NO") echo 'required';?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?=$input->input_attributes?>><?=$row->{$input->input_name}?></textarea></div></div>
            <?php
            }
            else
            {
            ?>              
                <div><input onchange="Input.ValidateInputAndTableSubmitRow(this)" id="<?=$input->input_id?>" name="<?=$input->input_name?>" type="<?=$input->input_type?>" class="<?=$input->input_class?>" <?=$input->input_attributes?> placeholder="<?=$input->input_placeholder?>" maxlength="<?=$input->input_maxlength?>" regex="<?=$input->input_regex?>" <?= $input->input_attributes?> value="<?=$row->{$input->input_name}?>"></div></div>
            <?php
            }   
        ?>
        </td>
        <?php                
        }
    }

    /**
     * Executes an insert command for the current working form
     */
	public static function InsertRecord($query_name)
	{
		$query = SystemQueries::GetQuery($query_name);
		return DBManager::ExecuteNonQuery($query[0]["query_text"]);
	}
	
    /**
     * Executes an update command for the current working form
     */
	public static function UpdateRecord($query_name)
	{
		$query = SystemQueries::GetQuery($query_name);
		return DBManager::ExecuteNonQuery($query[0]["query_text"]);
	}
	
    /**
     * Executes a delete command for the current working form
     */
	public static function DeleteRecord($query_name)
	{
		$query = SystemQueries::GetQuery($query_name);
		return DBManager::ExecuteNonQuery($query[0]["query_text"]);
	}
}
?>