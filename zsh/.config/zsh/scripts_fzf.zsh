# Custom fzf scripts


choose_aws_profile() {
  # Extract profile names from the AWS config file
  selected_profile=$(
    sed -n "s/\[profile \(.*\)\]/\1/gp" ~/.aws/config \
    | fzf \
    --height=20% \
    --min-height=12 \
    --margin=5%,2%,2%,5% \
    --border=rounded \
    --info=inline \
    --header="Choose AWS profile" \
  )
  export AWS_PROFILE=$selected_profile
  echo "Set AWS profile to '$selected_profile'"
}
alias awsprofile='choose_aws_profile'
