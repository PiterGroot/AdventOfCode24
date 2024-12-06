import subprocess
import os

def main():
    build_dir = "Build"
    os.makedirs(build_dir, exist_ok=True)  # Create the Build directory if it doesn't exist

    executable_name = "main.exe"  # Change this to the desired executable name if needed
    output_path = os.path.join(build_dir, executable_name)

    try:
        # Build the project, specifying the output file path
        build_result = subprocess.run(
            ["odin", "build", ".", f"-out:{output_path}"], check=True, capture_output=True, text=True
        )
        print("Build Output:\n", build_result.stdout)
    except subprocess.CalledProcessError as e:
        print("Build Failed:\n", e.stderr)
        return

    try:
        # Run the project executable
        run_result = subprocess.run(
            [output_path], check=True, capture_output=True, text=True
        )
        print("Run Output:\n", run_result.stdout)
    except subprocess.CalledProcessError as e:
        print("Run Failed:\n", e.stderr)


if __name__ == "__main__":
    main()
    os.system("pause")  # Wait for user input to close the window