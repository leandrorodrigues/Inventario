var $device_combo = $("#connection_end_interface_device_id");
var $interface_combo = $("#connection_interface1_id");
var $interface0_id = $("#connection_interface0_id");

$device_combo.change(function(){
    $.getJSON('/devices/' + $device_combo.val() + '/interfaces/available_interfaces.json?interface0_id=' + $interface0_id.val())
        .success(function(data){
            var html = ''

            $.each(data, function(i, interf){
                html += '<option value="' + interf.id +'">' + interf.title + '</option>';
            });

            $interface_combo.html(html);
        });
});