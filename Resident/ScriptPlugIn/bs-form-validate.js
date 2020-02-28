function extendedValidatorUpdateDisplay(obj) {
    // Appelle la méthode originale
    if (typeof originalValidatorUpdateDisplay === "function") {
        originalValidatorUpdateDisplay(obj);
    }
    // Récupère l'état du control (valide ou invalide) 
    // et ajoute ou enlève la classe has-error
    var control = document.getElementById(obj.controltovalidate);
    if (control) {
        var isValid = true;
        for (var i = 0; i < control.Validators.length; i += 1) {
            if (!control.Validators[i].isvalid) {
                isValid = false;
                break;
            }
        }
        if (isValid) {
            $(control).closest(".form-group").removeClass("has-error");
        } else {
            $(control).closest(".form-group").addClass("has-error");
        }
    }
}
// Remplace la méthode ValidatorUpdateDisplay
var originalValidatorUpdateDisplay = window.ValidatorUpdateDisplay;
window.ValidatorUpdateDisplay = extendedValidatorUpdateDisplay;