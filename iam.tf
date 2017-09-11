resource "aws_iam_group" "admin" {
	name = "awsadmin"
}

resource "aws_iam_group_policy_attachment" "administratorAccess" {
	group = "${aws_iam_group.admin.id}"
	policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "testadmin" {
	name = "testadmin"
}

resource "aws_iam_group_membership" "adminteam" {
	name = "adminteam"
	users = ["${aws_iam_user.testadmin.name}"]
	group = "${aws_iam_group.admin.id}"
}

resource "aws_iam_access_key" "testadmin" {
	user = "${aws_iam_user.testadmin.name}"
	pgp_key = "keybase:some_person_that_exists"
}

output "secret" {
  value = "${aws_iam_access_key.testadmin.encrypted_secret}"
}
