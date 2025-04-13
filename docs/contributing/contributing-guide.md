# Contributing to Enscribe
There are many ways in which people can contribute to Enscribe.

Before contributing, we advise you to read more on our microservices architecture and how they interact at [Microservices Architecture](../microservices/overview.md).

## Repositories

[Enscribe](https://github.com/A-Team-Name/Enscribe)

[Lambda-Kernculus](https://github.com/A-Team-Name/lambda-kernculus)

[Handwriting-Server](https://github.com/A-Team-Name/Handwriting-Server)

## Reporting Issues
To report an issue, please create a new issue on the relevant GitHub Repository. Please provide as much detail as possible, including steps to reproduce the issue, expected behavior, and any relevant screenshots or logs.

## Feature Requests
To request a new feature, please create a new issue on the relevant GitHub Repository. Please provide a detailed description of the feature, including how it would benefit users and any potential use cases.

## Code Contributions
To contribute code to the Enscribe project, you can follow these steps:
1. First create an issue or feature request to discuss your changes with the team.
2. Fork the repository you want to contribute to.
3. Create a new branch for your feature or bug fix.
4. Make your changes and commit them with a clear message.
5. Push your changes to your forked repository.
6. Create a pull request to the original repository, describing your changes and why they should be merged.
7. Wait for feedback from the team and make any necessary changes.

Note: For the Enscribe repository, all PRs must be made to the `dev` branch. For the Lambda-Kernculus and Handwriting-Server repositories, PRs can be made to the `main` branch.

## Handwriting Model Contributions
If you would like to train a new handwriting model, please follow these steps:
1. First create a feature request to discuss the new model with the team.
2. Fork the Handwriting-Server repository.
3. Create a new branch for your model.
4. Train your model independently.

### Integrating your model
There is an interface for the handwriting models that must be implemented for your model to work with the Handwriting-Server. This interface is defined in [Models](../../handwriting-server-documentation/models/).

There are some existing extended templates if you are able to transform your model into an ONNX model or HuggingFace VisionEncoderDecoderModel. Otherwise, please ensure that your model correctly returns an `Output` object.

Note: `top_preds` is a list of list of strings, where each sublist contains an ordered list of the top predictions for that character. The outer list represents the different characters in the image. e.g. [["a", "b", "c"], ["d", "e", "f"]] represents 2 characters, each with 3 predictions. `top_probs` is a list of list of floats, where each sublist contains the probabilities for the corresponding character in `top_preds`. e.g. [[0.9, 0.8, 0.7], [0.6, 0.5, 0.4]] represents the probabilities for the characters in `top_preds`.

4. Create a pull request to the Handwriting-Server repository, describing your changes and why they should be merged.
5. Wait for feedback from the team and make any necessary changes.

## Testing
We ask that you test all contributions before submitting a pull request. This includes running the tests and ensuring that all tests pass.

We will also run the tests on the pull request, but we ask that you do this before submitting to ensure that your changes do not break anything.

To test your changes locally you can do a few things:
### Write tests
We use [pytest](https://docs.pytest.org/en/latest/) for testing. You can run the tests using the following command:
```bash
pytest
```
### Run the application
You can run the application locally using Docker and Docker Compose. Please refer to the [Self-Hosting](../getting-started/self-hosting.md) guide for more information on how to set up the application locally.

The only changes you need to make to the docker-compose file is to remove the section you are developing and replace it with the local version (you can find in the repository you are working in).