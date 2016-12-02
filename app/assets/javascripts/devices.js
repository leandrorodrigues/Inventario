// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var $slot_container_combo = $('#device_container_slot_container_id');
var $slot_combo = $("#device_container_slot_container_slot_id");

var default_slot_option = $slot_combo.html();

$(document).on('change', '#device_container_slot_container_id', function(){
    var container_id = $slot_container_combo.val();
    var number_slots = $("#device_device_model_id :selected").data('number-slots');

    if(container_id > 0) {
        $.getJSON('/containers/available_slots.json?container_id=' + container_id + '&number_slots=' + number_slots, function (data) {
            var html = default_slot_option;
            $.each(data, function(i, slot) {
                html += '<option value = "' + slot.id + '">' + slot.title + '</option>';
            });
            $slot_combo.html(html);

            var auto_select = $slot_combo.data('selected');
            if(auto_select) {
                $slot_combo.val(auto_select);
                $slot_combo.data('selected', '');
            }
        });
    }
}).on('change', '#device_device_model_id', function(){
    $slot_container_combo.val($('#device_container_slot_container_id option:first-child').val());
    //resetar os valores dos options quando muda o modelo
    $slot_combo.html(default_slot_option);

});

$slot_container_combo.change();


var $number_field = $("#device_item_number");
var $number_field_addon = $number_field.next(".input-group-addon");

$number_field.change(function(){
    $.getJSON('/items/bynumber.json?number=' + $number_field.val()).success(function (data){
        if(data.devices.length > 0) {
            devices_name = data.devices.map(function(device){ return device.title }).join(', ');
            if(confirm('There are devices (' + devices_name + ') linked to this item number, are you sure to use this number?')) {
                $number_field_addon.html(data.title);
            }
            else {
                $number_field.val('').focus();
                $number_field_addon.html('');
            }
        } else {
            $number_field_addon.html(data.title);
        }
    }).error(function(){
        alert('Item not found. Please insert another number.');
        $number_field.val('').focus();
        $number_field_addon.html('');
    });

});