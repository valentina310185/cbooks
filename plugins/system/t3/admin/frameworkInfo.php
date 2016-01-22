<?php
/** 
 *------------------------------------------------------------------------------
 * @package       T3 Framework for Joomla!
 *------------------------------------------------------------------------------
 * @copyright     Copyright (C) 2004-2013 JoomlArt.com. All Rights Reserved.
 * @license       GNU General Public License version 2 or later; see LICENSE.txt
 * @authors       JoomlArt, JoomlaBamboo, (contribute to this project at github 
 *                & Google group to become co-author)
 * @Google group: https://groups.google.com/forum/#!forum/t3fw
 * @Link:         http://t3-framework.org 
 *------------------------------------------------------------------------------
 */

 
// no direct access
defined('_JEXEC') or die;
?>

<div class="span4">
  <div class="t3-admin-prd-preview">
    <img src="<?php echo T3_ADMIN_URL ?>/admin/framework_preview.png" alt="<?php echo JText::_('T3_FRMWRK_OVERVIEW') ?>" />
  </div>
</div>
<div class="span8">
  <div class="t3-admin-overview-header">
  	<h2>
      <?php echo JText::_('T3_FRMWRK_DESC_1') ?>
      <small style="display: block;"><?php echo JText::_('T3_FRMWRK_DESC_2') ?></small>
    </h2>
    <p><?php echo JText::_('T3_FRMWRK_DESC_3') ?></p>
  </div>
  <div class="t3-admin-overview-body">
    <h4><?php echo JText::_('T3_FRMWRK_DESC_4') ?></h4>
    <ul class="t3-admin-overview-features">
      <li><?php echo JText::_('T3_FRMWRK_DESC_5') ?></li>
      <li><?php echo JText::_('T3_FRMWRK_DESC_6') ?></li>
      <li><?php echo JText::_('T3_FRMWRK_DESC_7') ?></li>
      <li><?php echo JText::_('T3_FRMWRK_DESC_8') ?></li>
      <li><?php echo JText::_('T3_FRMWRK_DESC_9') ?></li>
    </ul>
  </div>
</div>