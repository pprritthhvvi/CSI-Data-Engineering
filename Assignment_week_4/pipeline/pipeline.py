import subprocess
import time

print("=" * 60)
print("LOCAL DATA PIPELINE STARTED")
print("=" * 60)

print("\n[1/3] Running Get Metadata Activity...")
subprocess.run(["python", "pipeline/get_metadata.py"])
time.sleep(1)

print("\n[2/3] Running Copy Data Activity...")
subprocess.run(["python", "pipeline/copy_data.py"])
time.sleep(1)

print("\n[3/3] Running Validation Activity...")
subprocess.run(["python", "pipeline/validate.py"])

print("\n" + "=" * 60)
print("PIPELINE EXECUTED SUCCESSFULLY")
print("=" * 60)