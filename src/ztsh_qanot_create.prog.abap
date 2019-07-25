*&---------------------------------------------------------------------*
*& Report  ZTSH_QANOT_CREATE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ztsh_qanot_create.
DATA: wa_head TYPE bapi2078_nothdri,
      it_items TYPE TABLE OF bapi2078_notitemi,
      wa_items TYPE  bapi2078_notitemi,
      it_cause TYPE TABLE OF bapi2078_notcausi,
      wa_cause TYPE bapi2078_notcausi,
      it_task  TYPE TABLE OF bapi2078_nottaski,
      wa_task  TYPE bapi2078_nottaski,
      it_partner TYPE TABLE OF bapi2078_notpartnri,
      wa_partner TYPE bapi2078_notpartnri,
      it_return TYPE TABLE OF bapiret2,
      wa_head_export type BAPI2078_NOTHDRE,
      wa_header_export type BAPI2078_NOTHDRE.

wa_head-short_text = 'Hello World'.
wa_head-priority = '2'.
wa_head-catalogue = 'D'.
wa_head-code_group = 'QM'.
wa_head-code = '1'.
*wa_head-deliv_numb = '0080603959'.
*wa_head-deliv_item = '000010'.
*wa_head-division = '01'.
*wa_head-salesorg = 'BM01'.
*wa_head-distr_chan = '03'.
wa_head-cust_no = 'PLANT_BPM2'.
wa_head-po_number = '4500648031'.
wa_head-po_item = '00010'.
wa_head-material_plant = 'BPM1'.
wa_head-purch_org = 'BP01'.
wa_head-pur_group = 'G99'.
wa_head-material = '000000000003000020'.
wa_head-VEND_MAT = 'Hello'.


wa_head-quant_complaint = '4.000'.
*wa_head-QTY_UNIT = '3.000'.

wa_items-item_key = '0001'.
wa_items-item_sort_no = '0001'.
wa_items-descript = 'Hello World Overview'.
wa_items-d_cat_typ = 'W'.
wa_items-d_codegrp = 'QM-D'.
wa_items-d_code = '0003'.
wa_items-dl_cat_typ = 'E'.
wa_items-dl_codegrp = 'QM'.
wa_items-dl_code = '0003'.
wa_items-quant_defects = '1'.
append wa_items to it_items.
clear wa_items.

wa_cause-cause_key = '0001'.
wa_cause-cause_sort_no = '0001'.
wa_cause-item_key = '0001'.
wa_cause-causetext = 'Cause Text'.
wa_cause-cause_codegrp = 'QM-C2'.
wa_cause-cause_code = '0019'.
wa_cause-item_sort_no = '0001'.
append wa_cause to it_cause.
clear wa_cause.

wa_task-task_key = '0001'.
wa_task-task_sort_no = '0001'.
wa_task-task_text = 'Task Text'.
wa_task-task_codegrp = 'QM-T2'.
wa_task-task_code = '0003'.
wa_task-partn_role = 'VU'.
wa_task-partner = 'BSHINN'.
wa_task-item_sort_no = '0001'.
append wa_task to it_task.
clear wa_task.

wa_partner-partn_role = 'LF'.
wa_partner-partner = '100383'.
append wa_partner to it_partner.
clear wa_partner.

wa_partner-partn_role = 'KU'.
wa_partner-partner = 'BSHINN'.
append wa_partner to it_partner.
clear wa_partner.

CALL FUNCTION 'BAPI_QUALNOT_CREATE'
  EXPORTING
*   EXTERNAL_NUMBER          =
    notif_type               = 'Q2'
    notifheader              = wa_head
*   TASK_DETERMINATION       = ' '
*   SENDER                   =
 IMPORTING
   NOTIFHEADER_EXPORT       = wa_head_export
 TABLES
   notitem                  = it_items
   notifcaus                = it_cause
*   NOTIFACTV                =
   notiftask                = it_task
   notifpartnr              = it_partner
*   LONGTEXTS                =
*   KEY_RELATIONSHIPS        =
   return                   = it_return.
BREAK-POINT.
CALL FUNCTION 'BAPI_QUALNOT_SAVE'
  EXPORTING
    number            = wa_head_export-notif_no
 IMPORTING
   NOTIFHEADER       = wa_header_export
 TABLES
   RETURN            = it_return       .

*data: it_return type TABLE OF bapiret2.
*CALL FUNCTION 'BAPI_QUALNOT_CHANGETSKSTAT'
*  EXPORTING
*    number                 = '000910000207'
*    task_key               = '0001'
*    task_code              = '02'
**   CARRIED_OUT_BY         =
**   CARRIED_OUT_DATE       =
**   CARRIED_OUT_TIME       =
*   LANGU                  = SY-LANGU
**   LANGUISO               =
**   TESTRUN                = ' '
** IMPORTING
**   SYSTEMSTATUS           =
**   USERSTATUS             =
* TABLES
*   RETURN                 = it_return.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
 EXPORTING
   wait          = 'X'
* IMPORTING
*   RETURN        =
          .
BREAK-POINT.
