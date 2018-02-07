function inputLengthCheck(eventInput){
	var inputText = $(eventInput).val();
	var inputMaxLength = $(eventInput).prop("maxlength");
	var j = 0;
	var count = 0;
	for(var i = 0;i < inputText.length;i++) { 
		val = escape(inputText.charAt(i)).length; 
		if(val == 6){
		j++;
		}
		j++;
		if(j <= inputMaxLength){
			count++;
		}
	}
	if(j > inputMaxLength){
		$(eventInput).val(inputText.substr(0, count));
	}
}


