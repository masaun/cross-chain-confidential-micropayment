use crate::{X402ApiRequestAuthorizer, test::utils};

#[test]
unconstrained fn increment_authorized_api_request_id_success() {
    let (env, contract_address, owner, _) = utils::setup_contract(false);

    env.call_private(owner, X402ApiRequestAuthorizer::at(contract_address).increment_authorized_api_request_id());

    let authorized_api_request_id = env.view_public(X402ApiRequestAuthorizer::at(contract_address).get_authorized_api_request_id());
    assert(authorized_api_request_id == 1);
}

#[test]
unconstrained fn does_it_fail_to_call_the_initializer() {
    let mut env = aztec::test::helpers::test_environment::TestEnvironment::new();

    let owner = env.create_light_account();

    let initializer_call_interface = X402ApiRequestAuthorizer::interface().constructor(owner);
    let x402_api_request_authorizer_deployer = env.deploy("@x402_api_request_authorizer/X402ApiRequestAuthorizer");
    let contract_address =
        x402_api_request_authorizer_deployer.with_public_initializer(owner, initializer_call_interface);

    env.call_private(owner, X402ApiRequestAuthorizer::at(contract_address).increment_authorized_api_request_id());

    let x402_api_request_authorizer = env.view_public(X402ApiRequestAuthorizer::at(contract_address).get_authorized_api_request_id());
    assert(x402_api_request_authorizer == 1);
}
